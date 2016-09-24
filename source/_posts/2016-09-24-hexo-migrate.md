---
layout: post
title: 从jekyll迁移到hexo
category: 技术
tags: [tech, linux, hexo, Next主题]
notebook: 待处理
photos:
---

{% cq %} 人生并不像火车要通过每个站似的经过每一个生活阶段。人生总是直向前行走，从不留下什么。

—— 刘易斯{% endcq %}


近期看到很多布置在**Git**上的*blog*都采用hexo + Next主题，简洁美观，因此动了心思利用hexo从新布置一下，于是今天下午就利用周六的时间进行了迁移。

现将迁移的方法与步骤记录如下，方便参考~~

## 1. shell环境代理设置

因为在安装node、hexo过程中发现有时候因为网速太慢，或者GFW影响，导致安装停顿，所以国内条件允许的情况下需要设置代理~设置方法如下：

```
export http_proxy=proxy_addr:port
```

## 2. Hexo与Next主题安装

### 2.1 安装node

如果本机没有安装过node则需要安装该环境，安装示例：

```
yum install nodejs
yum install npm
```

或者从源文件安装，å®装方法请自行搜索。

查看安装的node版本：

```
node -v
npm -v
```

### 2.2 安装Hexo与Next主题

```
sudo npm install -g hexo-cli
```

利用hexo初始化blog：

```
hexo init hexoBlog
# 如果init后不加文件夹的名字，则默认在当前文件夹初始化
cd hexoBlog
# 安装next主题
git clone https://github.com/iissnan/hexo-theme-next themes/next
```

## 3. blog初始配置与hexo使用

> 站点配置文件：*_config.yml*
> 主题配置文件：*themes/next/_config.yml*

### 3.1 更改主题与语言

```
vim _config.yml

theme: next
language: zh-Hans
```

Next主题设置：

```
vim themes/next/_config.yml

scheme: Pisces
```

### 3.2 hexo使用与预览

#### 3.2.1 常用命令

```
hexo new ”postName” #新建文章
hexo new page ”pageName” #新建页面
hexo generate #生成静态页面至public目录
hexo server #开启预览访问端口（默认端口4000，’ctrl + c’关闭server）
hexo deploy #将.deploy目录部署到GitHub
hexo help # 查看帮助
hexo version #查看Hexo的版本
```

#### 3.2.2 hexo预览

删除以前的静态html，从新产生然后再本地开启http服务即可：

```
hexo clean
hexo generate # 可以简化为hexo g；重新生成html
hexo server
```

成功生成html并无任何错误时，回显信息如下：

```
INFO  Start processing
INFO  Hexo is running at http://localhost:4000/. Press Ctrl+C to stop.
```

此时可以在本机访问[http://localhost:4000/](http://localhost:4000/)进行预览。

## 4. 主题配置与使用

主题配置方案主要参考iissnan开发的next主题帮助文件，具体请参考：
 - [http://theme-next.iissnan.com/getting-started.html](http://theme-next.iissnan.com/getting-started.html)
 - [http://theme-next.iissnan.com/theme-settings.html](http://theme-next.iissnan.com/theme-settings.html)
 - [http://theme-next.iissnan.com/third-party-services.html](http://theme-next.iissnan.com/third-party-services.html)

### 4.1 页面的配置

编辑主题配置文件：

```
vim themes/next/_config.yml
```

以tags为例，将想要添加的页面前#删除

```
http://theme-next.iissnan.com/theme-settings.html#tags-page
menu:
  home: /
  archives: /archives
  #about: /about
  #categories: /categories
  tags: /tags
  #commonweal: /404.html
```

同时利用hexo new page 添加tags页面：`hexo new page tags`

然后修改新生成的该页面模板：`vim source/tags/index.md`

```
type: 'tags'
comments: false
```

## 5. jekyll内容迁移

Jekyll与Hexo支持的post格式相近，因此只需要把Jekyll的 `_posts` 文件夹内的所有文件复制到 `source/_posts` 文件夹，并在 `_config.yml` 中修改 `new_post_name` 参数。

```
new_post_name: :year-:month-:day-:title.md
```
### 5.1 为posts添加目录

编辑主题配置文件：`vim themes/next/_config.yml`

```
toc:
  enable: true

  # Automatically add list,因为我习惯在写**md 文件**时，手动添加目录编号，因此这里设置为false
  number: false
```

## 6. hexo的自动部署

### 6.1 站点配置文件

首先，利用git对原有版本的blog进行备份，防止出现意外。

然后，安装deploy插件，实现自动部署功能。`npm install hexo-deployer-git --save`

同时部署多个平台的配置（branch和前面的逗号不能有空格），编辑站点é置文件：

```
deploy:
  type: git
  message: [message]
  repo:
    github: <repository url>,[branch]
    gitcafe: <repository url>,[branch]
    coding: <repository url>,[branch]
```

每次利用`hexo generate`产生网站之后，利用`hexo deploy`即可自动同步到以上git站点。

### 6.2 自动部署脚本

利用shell脚本，每次添加posts后自动进行git同步，产生静态站点，并推送到git pages页面。脚本内容如下：

```
#!/bin/bash

hexo clean
hexo g
hexo deploy
git add .
git commit -m 'add posts'
git push coding master:master
```

## 7. 其他坑

### 7.1 网速

npm安装某些插件时，可能因为网速原因卡住，可以终止之后再次运行；或者使用代理。

我一般终止之后重复安装，往复两次左右可以快速完成安装过程。

### 7.2 图片浮动效果

[fancybox使用](http://www.ezlippi.com/blog/2016/02/jekyll-to-hexo.html?utm_source=tuicool&utm_medium=referral)

在文章*.md文件的头上添加photos项即可，然后一行行添加你要展示的照片;也可只在post头部添加`photos:`，然后在需要添加图片的位置正常添加即可出现图片浮动效果。

```
title: Jekyll迁移到Hexo建立个人博客
photos:
- http://bruce.u.qiniudn.com/2013/11/27/reading/photos-0.jpg
- http://bruce.u.qiniudn.com/2013/11/27/reading/photos-1.jpg
```

测试图片：
![fig2](http://bruce.u.qiniudn.com/2013/11/27/reading/photos-1.jpg)

### 7.3 代码自动高亮

预览站点发现代码块内部没有自动高亮，查询后发现是因为没有自动匹配代码语言，需要编辑站点配置文件`vim _config.yml`

```
highlight:
  enable: true
  line_number: true
  auto_detect: true
```

## 8. 参考文献

 - [https://blog.yuanbin.me](https://blog.yuanbin.me/posts/2014/05/multi-deployment-with-hexo.html)
 - [http://laker.me](http://laker.me/blog/2015/09/28/15_0928_hexo_to_coding/)
 - [https://hexo.io/zh-cn/docs/migration.html](https://hexo.io/zh-cn/docs/migration.html)
 - [http://jelon.top/2016/05/15/fill-hexo/](http://jelon.top/2016/05/15/fill-hexo/)
 - [http://theme-next.iissnan.com/getting-started.html](http://theme-next.iissnan.com/getting-started.html#sidebar-settings)
 - [http://notes.iissnan.com/](http://notes.iissnan.com/)


