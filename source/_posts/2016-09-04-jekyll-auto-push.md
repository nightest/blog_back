---
layout: post
title: jekyll本地自动build与提交
category: 技术
tags: [tech, linux, jekyll, auto]
notebook: 待处理
---

@Date: 2016-09-03 16:34:09

--------

* content
{:toc}

---------

## 前期设置

前期设置包括绑定远程**git分支**，源代码绑定为**远程gcorigin主机**的**master分支**，而子文件夹**_site**中的build完成的软件则绑定为gcorigin的**coding-pages**分支，具体配置方法请参考[jekyll的迁移](http://nightest.coding.me/2016-09-02-jekyll/)。

## 自动化shell脚本

根据提交顺序，在blog所在文件夹内新建**add_post.sh**文件，内容如下：

```
git add .
git commit -m 'add posts'
git push gcorigin coding-pages:master
jekyll build
cd _site/
git add .
git commit -m 'add posts'
git push origin master:coding-pages
```

赋予该脚本运行权限，在**_posts**文件夹下添加文件后，在当前文件夹下用**./add_post.sh**的方式运行即可自动buld并提交静态网站。

## git pull远程分支

如果在其他机器上修改并提交给git仓库后，需要在本机进行同步，则需要使用命令：

    git pull gcorigin master:coding-pages

其中，**gcorigin**是远程主机名，**master**表示远程主机的分支名，**coding-pages**则为本地主机分支名，此句话表示把远程主机的**master**分支拉下并与本地**coding-pages**分支合并。
