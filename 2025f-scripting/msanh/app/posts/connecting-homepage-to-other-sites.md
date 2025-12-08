---
title: "Connecting homepage to my other sites"
pubDate: "2025-04-13"
tags: ["full-stack", "web development", "cloudflare", "workers", "api", "rss"]
draft: false
description: Gathering all my contents like the infinity gauntlet
heroImage: "/blog-content/connecting-homepage.png"
---

Due to the inherent boredom, I weaponized my ADHD (not clinically diagnosed) to rebuild my homepage from scratch. I set off with the goal of making my homepage more structured and giving up a bit of oversimplification to how the content is displayed. While the old version was **very** clean, it lacks the oomph that draws in visitors' attention.

A signficant "upgrade" to the site is that I've updated [my homepage](https://aaanh.com) to unify activities from a bunch of sources:

- GitHub (public events)
- Blog (RSS feed)
- Photo gallery (custom API)

The homepage acts as a unified frontend, but each data source has its own handling under the hood.

## GitHub Feed via Cloudflare Worker

To avoid hitting GitHub's rate limits or adding latency with client-side fetches, I use a Cloudflare Worker that runs on a cron schedule.

- **Scheduled sync**: The Worker is triggered every 15 minutes using Cloudflare's `scheduled` event. It fetches from `https://api.github.com/users/aaanh/events/public`.
- **KV for caching**: The fetched data is stored in Cloudflare KV using a single namespace and a known key (`"github:events"`), so it can be retrieved later without extra processing.
- **Manual override**: If I want to bypass the cache for any reason, I can hit the Worker with `?force=1` to do a live fetch and overwrite KV.
- **Frontend fetch**: On the homepage, I hit a lightweight API route that pulls from KV and serves the events JSON to the frontend.

This setup isolates the GitHub API calls, improves latency, and handles fallback gracefully if GitHub is down or rate-limiting.

## Blog Feed via RSS

The blog is built with Astro and exposes a standard RSS 2.0 feed at `/rss.xml`.

- **Client-side fetch**: The homepage does a fetch to `/rss.xml`, parses the XML using `DOMParser`, and maps it into a JS array of objects.
- **Structure**: Each `<item>` in the feed is parsed for `title`, `link`, `pubDate`, and optionally `description`.
- **No server needed**: The feed is public and static, so this can all happen client-side without auth or proxying.

If needed later, I could offload the RSS parsing to a backend route for pre-rendering or caching.

## Photo Gallery Feed via Proxy API

The photo gallery (on a subdomain) serves a custom JSON API at `/api/photos` which returns a paginated list of images and metadata.

- **CORS issue**: Direct client-side fetches from the homepage would be blocked due to cross-origin policy (gallery is on a different domain).
- **Proxy solution**: I added a new API route to the homepage (`/api/gallery-feed`) that does a server-side fetch to the gallery API and pipes the JSON response.
- **Frontend**: The homepage fetches from this internal route, avoiding CORS entirely.

This approach keeps the gallery decoupled while allowing full integration on the homepage.

## Deployment

- Homepage and API routes are deployed via **Vercel**.
- GitHub fetch Worker + KV cache run on **Cloudflare Workers**.
- Gallery runs separately but exposes a clean API.

## Summary

Everything is modular and built with long-term maintainability in mind. GitHub uses a caching Worker, the blog relies on native RSS, and the gallery works via a server-side proxy. Each piece handles its own fetch logic and failure cases.

Links:

- [Homepage](https://aaanh.com)  
- [GitHub](https://github.com/aaanh)  
- [Blog](https://aaanh.com/blog)  
- [Gallery](https://photo.aaanh.com)
