---
layout: post
title: hexo中添加footnotes
category: 技术
tags: [hexo, footnotes, linux]
notebook: 待处理
---

{% cq %}
如果你浪费了自己的年龄，那是挺可悲的。因为你的青春只能持续一点儿时间——很短的一点儿时间。
 ———— 王尔德
{% endcq %}

<!-- more -->

## 1. 安装hexo插件

```
npm install hexo-footnotes --save
```

如果Hexo不能自动发现插件，则需要手动安装插件[^5]，编辑`_config.yml`文件：

```
plugins:
  - hexo-footnotes
```

## 2. 使用方法

Markdown 内容：

```
basic footnote[^1]
here is an inline footnote[^2](inline footnote)
and another one[^3]
and another one[^4]

[^1]: basic footnote content
[^3]: paragraph
footnote
content
[^4]: footnote content with some [markdown](https://en.wikipedia.org/wiki/Markdown)
```

输出内容：

------------------------

basic footnote[^1]
here is an inline footnote[^2](inline footnote)
and another one[^3]
and another one[^4]


[^1]: basic footnote content
[^3]: paragraph
footnote
content
[^4]: footnote content with some [markdown](https://en.wikipedia.org/wiki/Markdown)

-------------------------

[^5]: [https://github.com/LouisBarranqueiro/hexo-footnotes](https://github.com/LouisBarranqueiro/hexo-footnotes)

