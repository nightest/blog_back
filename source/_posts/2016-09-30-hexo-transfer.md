---
layout: post
title: heading
category: 技术
tags: [hexo, linux, git]
notebook: 待处理
---

{% cq %}
你的心灵常常是战场。在这个战场上，你的理性与判断和你的热情与嗜欲开战。
————纪伯伦
{% endcq %}

<!-- more -->

以前的hexo在集群上布置，现在想迁移到我的笔记本上，发现和安装过程相似。

## 前期安装

我的laptop版本是**Ubuntu 14.04**，首先安装必须的软件：

```
sudo apt-get install nodejs node nodejs-legacy npm
sudo npm install -g hexo-cli
```

然后利用hexo初始化blog内容：

```
hexo init 03.hexoBlog
cd 03.hexoBlog
#安装主题
git clone https://github.com/iissnan/hexo-theme-next themes/next
#同步以前的配置
git init
git remote add coding git@git.coding.net:<yourname>/hexo_back.git
git pull coding master
##手动合并并更改配置
cp source/search/config_theme_bac themes/next/_config.yml
cp source/search/config_site_bac _config.yml
##根据package.json文件安装其他插件
npm install
```

## 正式使用

利用以下命令：

```
hexo clean
hexo g
hexo s
```

产生静态网站，并本地打开，测试是否安装成功。

可以创建文件`gen.sh`,自动产生并部署：

```
#!/bin/bash

hexo clean
hexo g
hexo deploy
git add .
git commit -m 'add posts'
git push coding master:master
```
