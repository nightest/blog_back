---
layout: post
title: 将Kindle转化为订阅中心
category: 技术
tags: [kindle, GAE, linux, shell]
notebook: 待处理
---

{% cq %}
没有播种，何来收获；
没有辛苦，何来成功；
没有磨难，何来荣耀；
没有挫折，何来辉煌。
——佩恩
{% endcq %}

<!-- more -->

很喜欢使用 Kindle 阅读的感觉，而且还能护眼，因此就把以前的一些 RSS 订阅转化到 kindle 的自动推送上来。首先，通过 Google 提供的免费GAE服务部署自动推送服务器。

##  1. cloud terminal 接入GAE

通过GAE账号，登录 [GAE](https://console.cloud.google.com/), 然后创建一个新的应用，通过右上角的标示进入远程 shell。在自己的文件夹下创建`src/<appid_name>/`文件夹并进入，然后 clone git 仓库：

```
git clone https://github.com/cdhigh/KindleEar.git kindleear
cd kindleear
```

## 2. 修改配置文件

在以下三个文件中修改一些参数：

  文件              |  待修改内容  | 说明                   |
-------------------|-------------|-----------------------|
app.yaml           | application | 你的ApplicationId      |
module-worker.yaml | application | 你的ApplicationId      |
config.py          | SRC_EMAIL   | 创建GAE工程的GMAIL邮箱   |
config.py          | DOMAIN      | 你申请的应用的域名        |

## 3. 部署KindleEar

在远程shell中，当前应用文件夹下：

```
#1st.
appcfg.py update app.yaml module-worker.yaml
#2nd.
appcfg.py update ./
```

部署成功，可以通过app网站访问：[https://push2kindle-145104.appspot.com/](https://push2kindle-145104.appspot.com/)。

## 4. 其他坑

### 遇到错误`wrong SRC_EMAIL`

到Gae后台的Settings页面，看看 已经授权的Email列表里面有没有你的发送邮箱地址，如果没有就添加即可。

### 管理Kindle的推送内容

在默认设置下，第三方服务通过推送邮箱发送给你的数字内容，都会在亚马逊云上保留一份存档，而这些文摘杂志等基本都没有保留的价值，定期到网站上去删除文档给用户增添了不少麻烦。为了防止Amazon云堆积太多第三方文档，登录自己的 Amazon 账号，进行如下设置，关闭 Psrsonal Document Archiving 自动保存服务即可：

![set](http://ocs218n9i.bkt.clouddn.com/57c00c5e3ce49.png_e600.jpg)

## 5. Kindle 图书资源列表

 - 苦瓜书盘：[http://kgbook.com/](http://kgbook.com/)

 - 子乌书简：[http://book.zi5.me/](http://book.zi5.me/)


## 参考内容

 1. [https://github.com/cdhigh/KindleEar/issues/313](https://github.com/cdhigh/KindleEar/issues/313)
 2. [http://www.nooidea.com/2011/03/kindle-books-online-resources.html](http://www.nooidea.com/2011/03/kindle-books-online-resources.html)
 
