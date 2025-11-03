---
layout: default
title: Home
---

A blog on technical and technology-related topics.

## Recent posts

{% for post in site.posts %}

- {{ post.date | date: "%b %-d, %Y" }} — [{{ post.title }}]({{ post.url | relative_url }})

{% endfor %}
