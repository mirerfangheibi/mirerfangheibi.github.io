---
layout: post
title: Morse code or a LinkedIn banner, that is the question!
date: 2023-09-25 12:00:00-0000
description: This is my first blog post on this website. So, the purpose of this post is to first trying out Jeykll and secondly,  to share a LinkedIn banner I made for myself.
categories: educational information-theory encoding linkedin 
giscus_comments: false
related_posts: true
thumbnail: assets/img/blogposts/20230925/1679912762385.jpeg
toc:
  sidebar: left
---

Hello and welcome to my very first blog post here! I'm thrilled to dip my toes into the world of writing with [Jekyll](https://jekyllrb.com/). I want this blog to be a blend of machine learning, science, and technology with a dash of personal experiences.

So, what's on the agenda for today? Well, I'm going to take you on a journey through the creation of my [LinkedIn](https://www.linkedin.com/in/mirerfangheibi) banner photo, spiced up with some tech talk. But before we dive into that, let's have a quick chat about Morse code – just in case it's not something you're familiar with. Don't worry; I promise it'll be a breeze!

## Morse Code

There are numerous articles about [Morse code](https://en.wikipedia.org/wiki/Morse_code) and because of its long history in telecommunications, it is also in many shows and movies. In short, Morse code is a pre-[information-theory](https://en.wikipedia.org/wiki/Information_theory) era encoding method for plain English. It is cleverly designed to minimize the length of the encoded message by incorporating the frequency of the occurrence of each letter in the English corpus, an early endeavor to do entropy encoding. It is not adaptive to each piece of text but rather relies on the stats of the English language in general. As an example, the letter E, the most frequent letter in English has the shortest code. There is a bit more modern version of this approach named [Huffman coding](https://en.wikipedia.org/wiki/Huffman_coding) that I will not write about. 

Talking about codes, what really is a code in the context of Morse code? Naturally, we might think of some sort of bit representation as it is the way we represent digital data and it is valid in some sense. Morse code uses _dit_ (_dot_) and _dah_ (_dash_) in a similar fashion. For example, the letter A is .-(dot dash). You can try out some combinations yourself online using the Morse Code World’s [tool](https://morsecode.world/international/translator.html).


## My LinkedIn Banner 

In essence, a LinkedIn banner is the rectangular image behind the profile photo. After I got my new profile photo, I wanted to have a unique banner image with some information about me. I ended up having a paragraph and two colors from my profile photo that I wanted to use to create a banner image. Here is the paragraph:

>I'm Mirerfan, a passionate data scientist, machine learning engineer, and computer vision expert. My focus is on delivering innovative and intellectual solutions that transform businesses. I have a deep interest in exploring complex datasets and designing creative, data-driven solutions. My expertise in computer vision enables me to develop algorithms and models that interpret visual data, providing valuable insights to businesses. I prioritize delivering unique, effective, and efficient solutions that solve complex problems.

So, I ended up encoding it in the Morse code that gave me the following paragraph:

>.. .----. -- / -- .. .-. . .-. ..-. .- -. --..-- / .- / .--. .- ... ... .. --- -. .- - . / -.. .- - .- / ... -.-. .. . -. - .. ... - --..-- / -- .- -.-. .... .. -. . / .-.. . .- .-. -. .. -. --. / . -. --. .. -. . . .-. --..-- / .- -. -.. / -.-. --- -- .--. ..- - . .-. / ...- .. ... .. --- -. / . -..- .--. . .-. - .-.-.- / -- -.-- / ..-. --- -.-. ..- ... / .. ... / --- -. / -.. . .-.. .. ...- . .-. .. -. --. / .. -. -. --- ...- .- - .. ...- . / .- -. -.. / .. -. - . .-.. .-.. . -.-. - ..- .- .-.. / ... --- .-.. ..- - .. --- -. ... / - .... .- - / - .-. .- -. ... ..-. --- .-. -- / -... ..- ... .. -. . ... ... . ... .-.-.- / .. / .... .- ...- . / .- / -.. . . .--. / .. -. - . .-. . ... - / .. -. / . -..- .--. .-.. --- .-. .. -. --. / -.-. --- -- .--. .-.. . -..- / -.. .- - .- ... . - ... / .- -. -.. / -.. . ... .. --. -. .. -. --. / -.-. .-. . .- - .. ...- . --..-- / -.. .- - .- -....- -.. .-. .. ...- . -. / ... --- .-.. ..- - .. --- -. ... .-.-.- / -- -.-- / . -..- .--. . .-. - .. ... . / .. -. / -.-. --- -- .--. ..- - . .-. / ...- .. ... .. --- -. / . -. .- -... .-.. . ... / -- . / - --- / -.. . ...- . .-.. --- .--. / .- .-.. --. --- .-. .. - .... -- ... / .- -. -.. / -- --- -.. . .-.. ... / - .... .- - / .. -. - . .-. .--. .-. . - / ...- .. ... ..- .- .-.. / -.. .- - .- --..-- / .--. .-. --- ...- .. -.. .. -. --. / ...- .- .-.. ..- .- -... .-.. . / .. -. ... .. --. .... - ... / - --- / -... ..- ... .. -. . ... ... . ... .-.-.- / .. / .--. .-. .. --- .-. .. - .. --.. . / -.. . .-.. .. ...- . .-. .. -. --. / ..- -. .. --.- ..- . --..-- / . ..-. ..-. . -.-. - .. ...- . --..-- / .- -. -.. / . ..-. ..-. .. -.-. .. . -. - / ... --- .-.. ..- - .. --- -. ... / - .... .- - / ... --- .-.. ...- . / -.-. --- -- .--. .-.. . -..- / .--. .-. --- -... .-.. . -- ... .-.-.-

Then, using the the two colors I had, created the image below and used it as my LinkedIn banner image that goes well with my profile photo.

<div class="row mt-3">
    <div class="col-sm mt-3 mt-md-0">
        {% include figure.html path="assets/img/blogposts/20230925/1679912762385.jpeg" class="img-fluid rounded z-depth-1" zoomable=true %}
    </div>
</div>
<div class="caption">
    The banner image of my personal <a href="https://www.linkedin.com/in/mirerfangheibi">LinkedIn</a> page.
</div>

This was the story behind my enigmatic LinkedIn banner and stay tuned for new posts!
