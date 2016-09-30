---
layout: post
title: 利用pairs画图
category: bioinformatics
tags: [R, bioinfo, linux, pairs]
notebook: R
---

@Date: 2016-09-05 14:48:04

--------

* content
{:toc}

---------


### pairs函数

当有多组样本数据，需要对比这些样本之间的相关性并且进行可视化时，可以通过R中base包的pairs函数实现：

```
# Load the iris dataset.
data(iris)

# Plot #1: Basic scatterplot matrix of the four measurements
pairs(~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width, data=iris)
# or
pairs(iris[,1:4])
```

![pairs](http://ocs218n9i.bkt.clouddn.com/u001.png)

### 加入相关系数

如果想在右上方区域显示相关系数，而并非像现在这样显示重复的散点图则：

```
# panel.smooth function is built in.
# panel.cor puts correlation in upper panels, size proportional to correlation
# digits 表示有效小数的位数, 默认为2
panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- abs(cor(x, y))
    txt <- format(c(r, 0.123456789), digits=digits)[1]
    txt <- paste(prefix, txt, sep="")
    if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
    text(0.5, 0.5, txt, cex = cex.cor * r)
}

# Plot #2: same as above, but add loess smoother in lower and correlation in upper
pairs(~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width, data=iris,
      lower.panel=panel.smooth, upper.panel=panel.cor,
      pch=20, main="Iris Scatterplot Matrix")
```

![function and pairs](http://ocs218n9i.bkt.clouddn.com/u002.png)

### 利用psych实现相似功能

利用psych的pairs.panels函数可以做出相似的图：

```
#install.packages('psych')
library(psych)
pairs.panels(iris[, 1:4], breaks = 30, ellipses = F)
```

![psych](http://ocs218n9i.bkt.clouddn.com/u003.png)

### 参考文献

 1. [http://personality-project.org/r/r.short.html](http://personality-project.org/r/r.short.html)
 2. [http://www.gettinggeneticsdone.com/2011/07/scatterplot-matrices-in-r.html](http://www.gettinggeneticsdone.com/2011/07/scatterplot-matrices-in-r.html)
 3. [http://moderntoolmaking.blogspot.com/2011/08/graphically-analyzing-variable.html](http://moderntoolmaking.blogspot.com/2011/08/graphically-analyzing-variable.html)







