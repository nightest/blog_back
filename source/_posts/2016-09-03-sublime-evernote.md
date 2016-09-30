---
layout: post
title: sublime设置与Evernote
category: 技术
tags: [tech, sublime, evernote]
notebook: 待处理
---

@Date: 2016-09-03 16:37:50

--------

* content
{:toc}

---------

**sublime** 是非常好用的编辑器，而**Evernote**是我经常用的笔记软件，如果能把二者结合将会十分完美。网上一搜索，果然可以，而且是用我最喜欢的**mardown**语法写笔记并且直接提交，因此马上使用该方法，特此记录如下：

## sublime配置

在使用sublime之前需要进行一系列的配置，配置方法如下：

#### 安装包管理插件

使用快捷键`ctr + ~`调出命令行模式，输入以下内容并回车：

```
import urllib.request,os; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); open(os.path.join(ipp, pf), 'wb').write(urllib.request.urlopen( 'http://sublime.wbond.net/' + pf.replace(' ','%20')).read())
```

等待片刻安装完毕即可用快捷键`ctrl + shift + p`调出输入框，输入install，调出包安装界面：

![install cmd](http://ocs218n9i.bkt.clouddn.com/sy23.png)

#### 安装所需插件

我使用的插件目录如下：

> - Anaconda
 - Markdown Extended
 - Markdown Preview
 - Monokai Extended
 - OmniMarkupPreviewer
 - sublime-evernote
 - Sublime Tmpl

#### 关联.md文件

默认情况下sublime不识别.md文件，因此，需要设置`view-syntax--open all with current...`

#### 我的配置

我的配置文件，选择Preferences/Settings - User，加入以下内容：

```
{
  "bold_folder_labels": true,
  "color_scheme": "Packages/Monokai Extended/Monokai Extended.tmTheme",
  "font_size": 16,
  "highlight_line": true,
  "ignored_packages":
  [
  ],
  "rulers":
  [
    80
  ],
  "save_on_focus_lost": true,
  "scroll_past_end": true,
  "show_encoding": true,
  "show_full_path": true,
  "show_line_endings": true,
  "spell_check": true,
  "tab_size": 2,
  "translate_tabs_to_spaces": true,
  "trim_trailing_white_space_on_save": true
}
```

## Evernote 相关设置

#### 获取Evernote授权

打开 Sublime Evernote 插件的设置文件 Preferences > Package Settings > Evernote > Settings - User

打开[https://app.yinxiang.com/api/DeveloperToken.action](https://app.yinxiang.com/api/DeveloperToken.action)并登录，获得应用授权。
将获得 Developer Token 和 NoteStore URL
将上面获取到的信息复制到相应的位置, 格式是：

```
{
 "noteStoreUrl": "你的 NoteStore URL",
 "token": "你的 Developer Token"
}
```

**PS:**

>token 是以S=开头的一串字符串
noteStoreUrl 是一段 http 地址，你需要手动将https替换成http
保存设置文件（可能还需要重启你的Sublime Text）之后，尝试打开一个笔记以确保你的印象笔记能正常工作

此时你可以ctrl + shift + p 调出Command palatte 输入 evernote: list recent notes,如果成功可以看到你最近的笔记。

#### 配置markdown模板

通过 Preferences > Bowse Packages... 找到SublimeTmpl文件夹中 找到 tmplates 文件夹新建一个md.tmpl的文档：
用Sublime 打开 md.tmpl 文档 写入以下格代码，保存 。

```
---
layout: post
title: heading
category: 技术
tags: [tech, disqus, linux, jekyll]
notebook: 待处理
---

@Date: ${date}

--------

* content
{:toc}

---------

```

> 模板配制完成，Evernote能识别这三个关键字 依次是标题，标签，笔记本。

#### 配置menu中的MD选项

在选项 File > New file(SublimeTmpl) > menu 照猫画虎的加入如下代码：

```
{
"caption": "md",
"command": "sublime_tmpl",
"args": {
"type": "md"
}
},
```

这样我们就能看到md的模版选项了。

#### 配置快捷键：

Evernote 的快捷键在 Key Bindings——User 中代码如下：

```
{ "keys": ["super+e"], "command": "show_overlay", "args": {"overlay": "command_palette", "text": "Evernote: "} },
{ "keys": ["ctrl+e", "ctrl+s"], "command": "send_to_evernote" },
{ "keys": ["ctrl+e", "ctrl+o"], "command": "open_evernote_note" },
{ "keys": ["ctrl+e", "ctrl+u"], "command": "save_evernote_note" },
```

> ["ctrl+e", "ctrl+s"] 就是先按完ctrl + e 后再按 ctrl + s

快捷键说明：

| Item      |    Value |
| :-------- | :--------|
| ctrl + alt + o  | 利用浏览器预览md文件 |
| ctrl + e, ctrl + s  | 发送到Evernote |
| ctrl + e, ctrl + u  | 保存已有笔记到Evernote |
| ctrl + e, ctrl + o  | 打开Evernote |


## 参考文献
 1. [http://www.jianshu.com/p/f5118d466f81](http://www.jianshu.com/p/f5118d466f81)
