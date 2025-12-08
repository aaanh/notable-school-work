import os
from django.conf import settings
import markdown

POSTS_DIR = os.path.join(settings.BASE_DIR, "app/posts")


def list_posts():
    """Return a sorted list of post slugs (filenames without .md)"""
    files = [f[:-3] for f in os.listdir(POSTS_DIR) if f.endswith(".md")]
    return sorted(files, reverse=True)  # newest first if filenames date-prefixed


def load_post(slug):
    """Load markdown file by slug and convert to HTML"""
    filepath = os.path.join(POSTS_DIR, f"{slug}.md")
    if not os.path.exists(filepath):
        return None

    with open(filepath, "r", encoding="utf-8") as f:
        text = f.read()

    html = markdown.markdown(
        text, extensions=["fenced_code", "toc", "tables", "codehilite"]
    )
    return html
