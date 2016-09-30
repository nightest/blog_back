---
layout: post
title: Sublime Text启用vim模式
category: 技术
tags: [tech, sublime, vim]
notebook: 待处理
---

@Date: 2016-09-03 15:32:01

--------

* content
{:toc}

---------

Vintage是Sublime Text的vi模式编辑包。 可以使用组合vi命令来调用Sublime Text的功能，包括多重选择。

## 开启vim模式

>打开**选项-setting user**并编辑。

Vintage默认是禁用的， 通过ignored_packages 配置。如果要从ignored packages列表中移除"Vintage"的话可以通过下面的方式编辑:
选择Preferences/Settings - Default菜单
编辑ignored_packages配置, 修改:

    "ignored_packages": ["Vintage"]

成:

    "ignored_packages": []

然后保存文件。

Vintage模式则已启用——你可以看到"INSERT MODE"显示在状态栏了。
Vintage默认是插入模式。可以添加:

    "vintage_start_in_command_mode": true

这项配置到User Settings里。

## 我的sublime配置文件

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

## 参考文献
 1. [http://feliving.github.io/Sublime-Text-3-Documentation/vintage.html](http://feliving.github.io/Sublime-Text-3-Documentation/vintage.html)
