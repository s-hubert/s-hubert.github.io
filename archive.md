---
layout: page
title: Blog Archive
---

{% for tag_entry in site.data.tags %}

{% assign tag_name = tag_entry[0] %}
{% assign tag_data = tag_entry[1] %}
{% assign tag_posts = site.tags[tag_name] %}
{% assign tag_slug = tag_name | slugify %}

## {{ tag_name }}

{: #{{ tag_slug }}}

{% if tag_data.description %}
{{ tag_data.description }}

{% endif %}
{% if tag_posts and tag_posts.size > 0 %}
{% assign posts = tag_posts | sort: 'date' | reverse %}

{% for post in posts %}

- {{ post.date | date: "%b %-d, %Y" }} — [{{ post.title }}]({{ post.url | relative_url }})

{% endfor %}
{% else %}
No posts found for this tag.

{% endif %}
{% endfor %}
