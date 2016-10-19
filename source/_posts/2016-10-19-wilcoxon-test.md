---
layout: post
title: 曼-惠特尼U检验与威尔科克森符号秩检验
category: statistics
tags: [bioinfo, statistics, R]
notebook: 待处理
---

曼-惠特尼U检验与威尔科克森符号秩检验是最常用的两独立样本非参数检验方法，无需对总体分布做出假定，可以用来比较两组分布未知的样品差异。

## 1. 曼-惠特尼U检验定义

曼-惠特尼U检验全称为**Mann-Whitney-Wilcoxon Test**，用来检验两组独立样品是否来自两组不同的样品。

>Two data samples are independent if they come from distinct populations and the samples do not affect each other. Using the Mann-Whitney-Wilcoxon Test, we can decide whether the population distributions are identical without assuming them to follow the normal distribution.

<!-- more -->

## 2. 曼-惠特尼U检验实现

在R中利用**wilcox.test**函数进行曼-惠特尼U检验。

```
#载入数据：
data(mtcars)
#1974年US，每加仑汽油行驶的英里数
mtcars$mpg
#0 = automatic, 1 = manual，手动挡与自动挡
mtcars$am
#检验
wilcox.test(mpg ~ am, data=mtcars)
```

检验结果：

```
> wilcox.test(mpg ~ am, data=mtcars)

        Wilcoxon rank sum test with continuity correction

data:  mpg by am
W = 42, p-value = 0.001871
alternative hypothesis: true location shift is not equal to 0

Warning message:
In wilcox.test.default(x = c(21.4, 18.7, 18.1, 14.3, 24.4, 22.8,  :
  cannot compute exact p-value with ties
```

原假设为两种变速器的油耗完全相同，**p-value**小于0.05，拒绝原假设，因此两种变速器的油耗有显著差异。

## 3. 威尔科克森符号秩检验

威尔科克森符号秩检验又叫**Wilcoxon Signed-Rank Test**, 用来进行配对样品的非参数检验。

>Two data samples are matched if they come from repeated observations of the same subject. Using the Wilcoxon Signed-Rank Test, we can decide whether the corresponding data population distributions are identical without assuming them to follow the normal distribution.

## 4. 威尔科克森符号秩检验实现

**immer**数据包含同一块地在1931和1932年的小麦产量。

载入数据：

```
> library(MASS)         # load the MASS package
> head(immer)
  Loc Var    Y1    Y2
1  UF   M  81.0  80.7
2  UF   S 105.4  82.3
    .....
```

进行检验：

```
> wilcox.test(immer$Y1, immer$Y2, paired=TRUE)

        Wilcoxon signed rank test with continuity correction

data:  immer$Y1 and immer$Y2
V = 368.5, p-value = 0.005318
alternative hypothesis: true location shift is not equal to 0

Warning message:
In wilcox.test.default(immer$Y1, immer$Y2, paired = TRUE) :
  cannot compute exact p-value with ties
```

根据*p-value*值，拒绝原假设，因此，产量在这两年之间存在显著的差异。

## 5. 参考

 1. [http://www.r-tutor.com/elementary-statistics/non-parametric-methods/mann-whitney-wilcoxon-test](http://www.r-tutor.com/elementary-statistics/non-parametric-methods/mann-whitney-wilcoxon-test)
 2. [http://www.r-tutor.com/elementary-statistics/non-parametric-methods/wilcoxon-signed-rank-test](http://www.r-tutor.com/elementary-statistics/non-parametric-methods/wilcoxon-signed-rank-test)


