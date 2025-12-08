import os
import re
from datetime import datetime
from django.conf import settings
from django.shortcuts import render, Http404
from django.utils.html import escape
import markdown
import yaml
from .utils.security import validate_slug, sanitize_frontmatter

POSTS_DIR = os.path.join(settings.BASE_DIR, "app", "posts")
CONTACT_FILE = os.path.join(settings.BASE_DIR, "app", "static", "contact.yaml")


def index(req):
    files = os.listdir(POSTS_DIR)
    posts = []
    for f in files:
        if f.endswith(".md"):
            slug = f[:-3]
            file_path = os.path.join(POSTS_DIR, f)
            with open(file_path, "r", encoding="utf-8") as file:
                raw_content = file.read()
            
            # Parse frontmatter for date
            frontmatter_match = re.match(r'^---\s*\n(.*?)\n---\s*\n(.*)$', raw_content, re.DOTALL)
            if frontmatter_match:
                frontmatter_text, _ = frontmatter_match.groups()
                try:
                    frontmatter = yaml.safe_load(frontmatter_text)
                except yaml.YAMLError:
                    frontmatter = {}
            else:
                frontmatter = {}
            
            # Sanitize frontmatter data
            frontmatter = sanitize_frontmatter(frontmatter)
            title = frontmatter.get('title', slug.replace("-", " ").title())
            date_str = frontmatter.get('pubDate', '')
            
            posts.append({
                "slug": slug, 
                "title": title,
                "date": date_str
            })
    
    # Sort by date (newest first)
    posts.sort(key=lambda x: datetime.fromisoformat(x['date']) if x['date'] else datetime.min, reverse=True)
    return render(req, "home.html", {"posts": posts})


def post(req, slug):
    try:
        # Validate slug to prevent path traversal
        if not validate_slug(slug):
            raise Http404("Invalid post slug")
        
        file_path = os.path.join(POSTS_DIR, f"{slug}.md")
        # Ensure the resolved path is within POSTS_DIR
        if not os.path.abspath(file_path).startswith(os.path.abspath(POSTS_DIR)):
            raise Http404("Invalid post path")
        
        if not os.path.exists(file_path):
            raise Http404("Post not found")
        with open(file_path, "r", encoding="utf-8") as f:
            raw_content = f.read()
        
        # Parse frontmatter
        frontmatter_match = re.match(r'^---\s*\n(.*?)\n---\s*\n(.*)$', raw_content, re.DOTALL)
        if frontmatter_match:
            frontmatter_text, markdown_content = frontmatter_match.groups()
            try:
                frontmatter = yaml.safe_load(frontmatter_text)
            except yaml.YAMLError:
                frontmatter = {}
        else:
            frontmatter = {}
            markdown_content = raw_content
        
        md = markdown.Markdown(extensions=["fenced_code", "toc", "tables", "codehilite"])
        content = md.convert(markdown_content)
        toc = md.toc
        has_headings = bool(md.toc and md.toc.strip() and '<li>' in md.toc)
        title = frontmatter.get('title', slug.replace("-", " ").title())
        
        # Get all posts for sidebar
        files = os.listdir(POSTS_DIR)
        all_posts = []
        for f in files:
            if f.endswith(".md"):
                post_slug = f[:-3]
                post_file_path = os.path.join(POSTS_DIR, f)
                with open(post_file_path, "r", encoding="utf-8") as post_file:
                    post_raw_content = post_file.read()
                
                # Parse frontmatter for sidebar posts
                post_frontmatter_match = re.match(r'^---\s*\n(.*?)\n---\s*\n(.*)$', post_raw_content, re.DOTALL)
                if post_frontmatter_match:
                    post_frontmatter_text, _ = post_frontmatter_match.groups()
                    try:
                        post_frontmatter = yaml.safe_load(post_frontmatter_text)
                    except yaml.YAMLError:
                        post_frontmatter = {}
                else:
                    post_frontmatter = {}
                
                # Sanitize sidebar post frontmatter
                post_frontmatter = sanitize_frontmatter(post_frontmatter)
                post_title = post_frontmatter.get('title', post_slug.replace("-", " ").title())
                post_date = post_frontmatter.get('pubDate', '')
                all_posts.append({"slug": post_slug, "title": post_title, "date": post_date})
        
        # Sort sidebar posts by date too
        all_posts.sort(key=lambda x: datetime.fromisoformat(x['date']) if x['date'] else datetime.min, reverse=True)
        
        return render(req, "post.html", {
            "content": content, 
            "title": title,
            "frontmatter": frontmatter,
            "all_posts": all_posts,
            "current_slug": slug,
            "toc": toc,
            "has_headings": has_headings
        })
    except FileNotFoundError:
        raise Http404("Post not found")
    except Exception as e:
        print(f"Error rendering post {slug}: {str(e)}")
        raise Http404("An error occurred while rendering the post")


def contact(req):
    try:
        with open(CONTACT_FILE, "r", encoding="utf-8") as f:
            yaml_data = yaml.safe_load(f)
        contact_data = yaml_data.get('contact', {})
        return render(req, "contact.html", {"contact": contact_data})
    except FileNotFoundError:
        raise Http404("Contact information not found")
    except Exception as e:
        print(f"Error loading contact data: {str(e)}")
        raise Http404("An error occurred while loading contact information")
