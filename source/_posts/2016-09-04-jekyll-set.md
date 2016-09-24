---
layout: post
title: jekyll部署中的问题
category: 技术
tags: [tech, disqus, linux, jekyll]
notebook: 待处理
---

@Date: 2016-09-03 22:37:45

--------

* content
{:toc}

---------

## 1. 如何添加代码高亮

不同编程语言的关键词、语法不同，因此需要对不同的位置进行高亮设置，因为目前**jekyll**默认编辑器为**kramdown**，并不支持**pygments**的代码高亮渲染，因此需要改为**rouge**进行渲染。

**jekyll 3.0**的修改方法如下，修改**_config.yml**文件：

```
markdown: kramdown
highlighter: rouge
```

添加**highlighter**为**rouge**即可。

**Ref:** [https://sacha.me/articles/jekyll-rouge/](https://sacha.me/articles/jekyll-rouge/)

## 2. 修改代码块背景与字体颜色

修改文件 **media/css/style.css**即可：

```
pre,code{font-family:Menlo,"Andale Mono",Consolas,"Courier New",Monaco,monospace;font-size:14px;color:#586e75;}
code{background-color:#fdf6e3;}
```

在线调色工具：[http://www.atool.org/colorpicker.php](http://www.atool.org/colorpicker.php)

## 3. 绑定域名

为了方便访问，我从namecheap上购买了一个top域名，绑定方法如下~

#### **coding net** 设置

首先打开**coding net**中该项目的**pages服务**选项，绑定一个自定义域名。

![binding domain name](http://ocs218n9i.bkt.clouddn.com/23g2g.png)

#### DNS 设置

然后打开**namecheap**的[控制面板](https://ap.www.namecheap.com/),添加**CNAME**，如下图：

![DNS setting](http://ocs218n9i.bkt.clouddn.com/typ1.png)

**Ref:**

 1. [http://www.jeyzhang.com/blog-on-gitcafe-with-dns-settings.html](http://www.jeyzhang.com/blog-on-gitcafe-with-dns-settings.html)



