---
layout: page
permalink: /ml_resources/
title: study resources
description: this page is being updated actively with new resources for machine learning ...
nav: true
nav_order: 4
---

A curated collection of free, high-quality machine learning resources: books and courses I've found valuable, whether you're just starting out or already experienced. Nothing is hosted here; every link goes to the original source. The list began as my [Machine-Learning-Resources](https://github.com/mirerfangheibi/Machine-Learning-Resources) GitHub repository. Have a suggestion? Send it through this [Google Form](https://forms.gle/owPEGk4KCGQ3uPqX6).

{% include resources_filter.liquid %}

{% include resources_tabs.liquid %}

<div class="res-panel" id="Books" role="tabpanel" aria-labelledby="tab-Books">
  <p class="res-panel-intro">Books on machine learning and related math, statistics and computer science, newest first.</p>
  {% include books_grid.liquid %}
</div>

<div class="res-panel" id="Courses" role="tabpanel" aria-labelledby="tab-Courses">
  <p class="res-panel-intro">Free courses with lecture videos or notes, newest first. More are moving over from the GitHub repository.</p>
  {% include courses_grid.liquid %}
</div>
