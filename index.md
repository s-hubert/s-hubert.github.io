---
layout: default
title: Home
---

A blog on technical and technology-related topics.

## Recent posts

{% for post in site.posts %}

- {{ post.date | date: "%b %-d, %Y" }}
  {%- if post.tags and post.tags.size > 0 -%}
  (Tags: {%- for tag in post.tags -%}[{{ tag }}]({{ '/archive.html#' | append: tag | relative_url }}){% unless forloop.last %}, {% endunless %}{%- endfor -%})
  {%- endif -%}
  — [{{ post.title }}]({{ post.url | relative_url }})

{% endfor %}
