---
layout: default
title: Home
---

A blog on technical and technology-related topics.

## Recent posts

{% for post in site.posts %}

- {{ post.date | date: "%b %-d, %Y" }}
  {%- if post.tags and post.tags.size > 0 -%}
  (Tags: {%- for tag in post.tags -%}<a href="{{ '/tag/' | append: tag | slugify | append: '/' | relative_url }}" rel="tag">{{ tag }}</a>{% unless forloop.last %}, {% endunless %}{%- endfor -%})
  {%- endif -%}
  — [{{ post.title }}]({{ post.url | relative_url }})

{% endfor %}
