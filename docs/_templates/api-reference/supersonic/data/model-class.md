---
layout: "docs_api"
title: Supersonic API reference
header_sub_title: supersonic.data.Model
section_id: data
subsection_id: model-class
---

<h1>Model Class Description</h1>
<hr>

{% assign class = site.data.supersonic.data.model.Model-class %}
{% include api_class.md class=class %}

<h2>Model Class Methods</h2>

The following methods are properties of the Model class.

{% assign method = site.data.supersonic.data.model.Model-all %}
{% include api_method.md method=method %}

{% assign method = site.data.supersonic.data.model.Model-find %}
{% include api_method.md method=method %}

{% assign method = site.data.supersonic.data.model.Model-findAll %}
{% include api_method.md method=method %}

{% assign method = site.data.supersonic.data.model.Model-fromJson %}
{% include api_method.md method=method %}

{% assign method = site.data.supersonic.data.model.Model-one %}
{% include api_method.md method=method %}

<br><br>

<h1>Model Class Instance Description</h1>
<hr>

{% assign method = site.data.supersonic.data.model.Model-instance %}
{% include api_class_instance.md method=method %}

<h2>Class Instance Methods</h2>

The following methods are properties of a Model class instance.

{% assign method = site.data.supersonic.data.model.Model-save %}
{% include api_method.md method=method instance_method=true %}

{% assign method = site.data.supersonic.data.model.Model-delete %}
{% include api_method.md method=method instance_method=true %}
