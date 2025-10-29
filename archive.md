---
layout: page
title: Blog Archive
---

{% for tag in site.tags %}

### <a href="{{ '/tag/' | append: tag[0] | slugify | append: '/' | relative_url }}" rel="tag">{{ tag[0] }}</a>

{% for post in tag[1] %}

- [{{ post.date | date: "%B %Y" }} - {{ post.title }}]({{ post.url }})

{% endfor %}

{% endfor %}
