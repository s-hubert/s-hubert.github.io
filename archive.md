---
layout: page
title: Blog Archive
---

{% for tag in site.tags %}

### [{{ tag[0] }}]({{ '/tag/' | append: tag[0] | slugify | append: '/' | relative_url }})

{% for post in tag[1] %}

- [{{ post.date | date: "%B %Y" }} - {{ post.title }}]({{ post.url }})

{% endfor %}

{% endfor %}
