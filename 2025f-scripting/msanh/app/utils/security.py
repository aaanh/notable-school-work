import re
from django.utils.html import escape

def validate_slug(slug):
    """Validate slug to prevent path traversal attacks"""
    if not slug or not isinstance(slug, str):
        return False
    
    # Only allow alphanumeric, hyphens, and underscores
    if not re.match(r'^[a-zA-Z0-9-_]+$', slug):
        return False
    
    # Prevent path traversal
    if '..' in slug or '/' in slug or '\\' in slug:
        return False
    
    return True

def sanitize_frontmatter(frontmatter):
    """Sanitize frontmatter data to prevent XSS"""
    if not isinstance(frontmatter, dict):
        return {}
    
    sanitized = {}
    for key, value in frontmatter.items():
        if isinstance(key, str):
            sanitized[escape(key)] = escape(str(value)) if value else ''
    
    return sanitized