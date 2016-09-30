---
layout: post
title: 如何使用代理进行apt-get更新
category: 技术
tags: [tech, shell, linux, apt-get]
notebook: 待处理
---

{% cq %}
时间不是金钱，不是任何可以失而复得的物质。你一旦把它轻易失去，它就永远同你无情的分别。最可怕的事情是：它离开你时，还从你身上窃去了最珍贵的财产——青春和生命。
{% endcq %}

<!-- more -->

## 1. apt-get 更新

如果计算机需要通过代理访问网络，那么Ubuntu更新时，因为apt-get并不会自动调用系统默认的代理设置，所以会显示更新失败。[^1]

在/etc/apt/apt.conf.d/文件夹下创建文件 95proxies 并添加以下内容：

```
Acquire::http::proxy "http://192.168.2.236:3128/";
```

如果是其他种类的代理，请按照以下方式设置：

```
Acquire::http::proxy "http://www-proxy.ericsson.se:8080/";
Acquire::ftp::proxy "ftp://www-proxy.ericsson.se:8080/";
Acquire::https::proxy "https://www-proxy.ericsson.se:8080/";
```

## 2. 为shell设置代理

通过命令为当前shell设置代理[^2]：

```
$ export http_proxy=http://server-ip:port/
$ export http_proxy=http://127.0.0.1:3128/
$ export http_proxy=http://proxy-server.mycorp.com:3128/
```

如果需要用户名密码，则：

```
$ export http_proxy=http://foo:bar@server-ip:port/
$ export http_proxy=http://foo:bar@127.0.0.1:3128/
$ export http_proxy=http://USERNAME:PASSWORD@proxy-server.mycorp.com:3128/
```

如果需要为所有打开的终端都设置相同的代理，则应该编辑`~/.bashrc`文件，添加以上内容：

```
export http_proxy=http://proxy-server.mycorp.com:3128/
```

## 3. 源列表

源列表：[http://wiki.ubuntu.org.cn/%E6%BA%90%E5%88%97%E8%A1%A8](http://wiki.ubuntu.org.cn/%E6%BA%90%E5%88%97%E8%A1%A8)

[^1]: [http://askubuntu.com/questions/164169/unable-to-connect-error-with-apt-get](http://askubuntu.com/questions/164169/unable-to-connect-error-with-apt-get)
[^2]: [http://www.cyberciti.biz/faq/linux-unix-set-proxy-environment-variable/](http://www.cyberciti.biz/faq/linux-unix-set-proxy-environment-variable/)
