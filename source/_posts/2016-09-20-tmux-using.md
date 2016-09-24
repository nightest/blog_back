---
layout: post
title: tmux安装与使用
category: 技术
tags: [tech, tmux, linux, shell]
notebook: 待处理
---

@Date: 2016-09-19 16:29:17

--------

* content
{:toc}

---------

Tmux是一个优秀的终端复用软件，支持多标签，也支持窗口内部面板的分割，更重要的是，Tmux提供了窗体随时保存和恢复的功能。不仅如此，你还可以通过 Tmux 使终端会话运行于后台或是按需接入、断开会话。

## 1. 下载源代码

```
git clone https://github.com/tmux/tmux.git tmux
cd tmux
sh autogen.sh
./configure --prefix=/gpfs01/home/path/to/tmux
```

<!-- more -->

### 1.1 提示需要libevent

编译过程终端，
提示：`configure: error: "libevent not found"`

#### 安装libevent

```
#./configure --prefix=/gpfs01/home/path/to/tmux
curl -O https://cloud.github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
tar xvf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
mkdir ../libevent
./configure --prefix=/gpfs01/home/path/to/tmux/src/libevent
make
make install
```

### 1.2 设置libevent环境变量并编译tmux

```
CFLAGS='-I/gpfs01/home/path/to/tmux/src/libevent/include' LDFLAGS='-L/gpfs01/home/path/to/tmux/src/libevent/lib' ./configure --prefix=/gpfs01/home/path/to/tmux

make
make install
```

### 1.3 运行tmux

将tmux安装路径加入到环境变量中，然后用tmux命令打开。

#### 1.3.1 提示没有**libevent-2.0.so.5**文件

因为libevent没有安装到默认lib路径下，因此
提示：`libevent-2.0.so.5: cannot open shared object file: No such file or directory`

*如果有超级用户权限：*

```
cp /gpfs01/home/path/to/tmux/src/libevent/lib/libevent-2.0.so.5 /usr/lib
```

*如果没有root权限：*

```
LD_LIBRARY_PATH=/gpfs01/home/path/to/tmux/src/libevent/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
```

### 1.4 美化 Tmux 的状态栏

下载源文件：

```
git clone https://github.com/erikw/tmux-powerline.git tmux-powerline
```

配置tmux加入theme部分：

```
# tmux theme, colors and status line
# available themes:
#   - powerline (a powerline inspired theme)
#   - powerline_patched_font (a powerline inspired theme using a patched font)
tmux_conf_theme=powerline
set -g status-bg '#666666'
set -g status-fg '#aaaaaa'
set -g status-left-length 150
set -g status-left '[#(/gpfs01/home/path/to/tmux/tmux-powerline/powerline.sh left)]'
```

## 2. Tmux配置

编辑文件：vim ~/.tmux.conf

```
#重新绑定快捷键bind
set -g prefix C-a
unbind C-b
```

```
#快速载入配置
bind e new-window -n '~/.tmux.conf' '${EDITOR:-vim} ~/.tmux.conf && tmux source ~/.tmux.conf && tmux display "~/.tmux.conf sourced"'
bind r source-file ~/.tmux.conf \; display 'Reloaded!'
```

```
#主题设置
tmux_conf_theme=powerline
set -g status-bg '#666666'
set -g status-fg '#aaaaaa'
set -g status-left-length 150
set -g status-left '[#(/gpfs01/home/path/to/tmux/tmux-powerline/powerline.sh left)]'
```

```
#分割窗口
unbind %
bind | split-window -h
bind - split-window -v
```

```
# pane navigation
bind -r h select-pane -L  # move left
bind -r j select-pane -D  # move down
bind -r k select-pane -U  # move up
bind -r l select-pane -R  # move right
bind > swap-pane -D       # swap current pane with the next one
bind < swap-pane -U       # swap current pane with the previous one
```

```
# pane resizing
bind -r H resize-pane -L 2
bind -r J resize-pane -D 2
bind -r K resize-pane -U 2
bind -r L resize-pane -R 2
```

## 3. 主要快捷键

```
会话的创建和保存
终端运行tmux + 会话名，创建或打开会话
前缀 + d 退出并保存会话
窗口操作
前缀 + c 创建一个新的window
前缀 + b 重命名当前window
前缀 + & 关闭当前windows
前缀 + n 移动到下一个窗口
前缀 + p 移动到前一个窗口
前缀 + l 切换到上一个窗口

运行C-b d   //返回主 shell ，detach, tmux 依旧在后台运行，里面的命令也保持运行状态
tmux attach  //恢复tmux
C-b w // 以菜单方式显示及选择窗口
C-b s // 以菜单方式显示和选择会话

-- 快捷键
tmux 的使用主要就是依靠快捷键，通过 C-b 来调用。
C-b ?  // 显示快捷键帮助
C-b C-o  //调换窗口位置
C-b 空格键  //采用下一个内置布局.
             在预置的面板布局中循环切换；依次包括even-horizontal、even-vertical、main-horizontal、main-vertical、tiled
C-b ! // 把当前窗口变为新窗口
C-b  "  // 模向分隔窗口
C-b % // 纵向分隔窗口
C-b q // 显示分隔窗口的编号
C-b o // 跳到下一个分隔窗口
C-b 上下键 // 上一个及下一个分隔窗口
C-b C-方向键 //调整分隔窗口大小

C-b & // 确认后退出 tmux
C-b c // 创建新窗口

C-b ，//修改当前窗口名称
C-b 0~9 //选择几号窗口
C-b c // 创建新窗口
C-b n // 选择下一个窗口
C-b l // 最后使用的窗口
C-b p // 选择前一个窗口

C-b t //显示时钟
C-b Ctrl+方向键 以1个单元格为单位移动边缘以调整当前面板大小
C-b Alt+方向键 以5个单元格为单位移动边缘以调整当前面板大小
C-b { 向前置换当前面板
C-b } 向后置换当前面板
```

## 4. 参考文献

 1. [http://www.ezlippi.com/](http://www.ezlippi.com/blog/2016/01/tmux-guide.html)
 2. [http://blog.jobbole.com](http://blog.jobbole.com/87584/)
