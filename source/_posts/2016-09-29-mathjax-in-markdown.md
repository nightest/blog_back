---
layout: post
title: Markdown中使用MathJax
category: 技术
tags: [Markdown, hexo, MathJax]
notebook: 待处理
---

{% cq %}
零星的时间，如果能敏捷地加以利用，可成为完整的时间。所谓“积土成山”是也，失去一日甚易，欲得回已无途。
         ———— 卡耐基
{% endcq %}

<!-- more -->

## 1. 如何使Hexo支持MathJax

我使用的是hexo下的[Next主题](http://theme-next.iissnan.com/)，直接修改主题配置文件`theme/next/_config.yml`。 将 `mathjax` 下的 `enable` 设定为 `true` 即可。 `cdn` 用于指定 MathJax 的脚本地址，默认是 MathJax 官方提供的 CDN 地址。

```
# MathJax Support
mathjax:
  enable: true
  cdn: //cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML
```

## 2. 如何在Markdown中添加MathJax公式

为 markdown 添加 MathJax 支持后，在markdown文件中添加数学公式方法如下：

### 2.1 行内公式与行间公式

输入`$\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}$`来显示行内公式：$\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}$。

或者使用`$$\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}$$`来展示行间公式：
$$\sum_{i=0}^n i^2 = \frac{(n^2+n)(2n+1)}{6}$$

### 2.2 显示希腊字母

|命令 | 显示  |  命令 | 显示|
|:----|:------|:-----|:-----|
|\alpha|α| \beta |β|
|\gamma|γ| \delta|δ|
|\epsilon|ϵ| \zeta |ζ|
|\eta|η| \theta|θ|
|\iota |ι| \kappa|κ|
|\lambda |λ| \mu |μ|
|\xi|ξ| \nu| ν|
|\pi|π| \rho|ρ|
|\sigma|σ| \tau|τ|
|\upsilon|υ| \phi|ϕ|
|\chi|χ| \psi|ψ|
|\omega|ω|

如果需要显示大写的希腊字母，只需要将首字母大写即可：`\Gamma` $\Gamma$ 。

## 3. 其他参考

 1. [http://blog.csdn.net/bendanban/article/details/44196101](http://blog.csdn.net/bendanban/article/details/44196101)
 2. [http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference](http://meta.math.stackexchange.com/questions/5020/mathjax-basic-tutorial-and-quick-reference)
