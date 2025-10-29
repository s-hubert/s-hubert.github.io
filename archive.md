---
layout: page
title: Blog Archive
---

{% for tag in site.tags %}

{% assign tag_slug = tag[0] | slugify %}

### [{{ tag[0] }}]({{ '/tag/' | append: tag_slug | append: '/' | relative_url }})

{% for post in tag[1] %}

- [{{ post.date | date: "%B %Y" }} - {{ post.title }}]({{ post.url }})

{% endfor %}

{% endfor %}
