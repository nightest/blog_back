---
layout: post
title: 利用Long Ranger分析10X测序数据(一)
category: bioinformatics
tags: [bioinfo, linux, 10X, long ranger]
notebook: bioinfo
---

{% cq %}
有三件事人类都要经历：出生生活和死亡。他们出生时无知无觉，死到临头，痛不欲生，活着的时候却又怠慢了人生。
———— 拉布吕耶尔
{% endcq %}

<!-- more -->

## 1. 什么是Long Ranger

Long Ranger是10X Genomics公司开发的一套*Pipeline*，用于10X Genomicsæ°据的比对，SNP检测与phasing，indel与SV的检测等。该*Pipleline*主要包含以下5个部分，

 - `longranger mkfastq` 包含Illumina 公司的bcl2fastq功能，能够根据barcode demultiplex样品，生成 FASTQ 文件。亲自测试后发现就相当于bcl2fastq功能
 - `longranger wgs` 输入文件为全基因组的FASTQ文件，然后进行比对，去冗余，过滤，最后根据GemCode特有的barcodes信息 call and phase **_SNPs, indels, SVs_**
 - `longranger targeted` 输入文件为目标样品的FASTQ文件，然后进行alignment, de-duplication, and filtering; 最后根据barcodes信息  call and phase **_SNPs, indels, SVs_**
 - `longranger basic` 输入文件为 longranger basic 产生的FASTQ文件，找出并区分不同的barcodes及reads
 - `longranger align` basic pipeline部分再加上序列比对

Long Ranger 利用 FreeBayes （内部集成）或者GATK（用户提供）进行SNP检测。


## 2. Long Ranger 运行要求

Linux系统要求：

```
16-core Intel or AMD processor
96GB RAM
2TB free disk space
64-bit CentOS/RedHat 5.2 or Ubuntu 8
```

Cluster集群要求：

```
8-core Intel or AMD processor per node
6GB RAM per core
Shared filesystem (e.g. NFS)
SGE or LSF
```

## 3. Long Ranger 下载安装

### 3.1 相关软件下载

[最新相关软件下载地址](http://support.10xgenomics.com/genome-exome/software/downloads/latest)

#### Long Ranger 2.1.1

>Linux 64-bit – 326 MB – md5sum: e39a0f12cde47e031431fd1077eacd7a

```
wget --no-check-certificate -O longranger-2.1.1.tar.gz "https://s3-us-west-2.amazonaws.com/10x.downloads/longranger-2.1.1.tar.gz?AWSAccessKeyId=AKIAJAZONYDS6QUPQVBA&Expires=1474895729&Signature=URv51xh85BxZmGu97nj03sn0FgE%3D"
```
#### hg 19

>Linux 64-bit – 5.0 GB – md5sum: 20068c9e5d799ce2e8f5a7c5502a8a7d

```
wget --no-check-certificate https://s3-us-west-2.amazonaws.com/10x.datasets/refdata-hg19-2.1.0.tar.gz
```

hg18和GRCh36对应，hg19和GRCh37对应，hg38和GRCh38对应（以后数字应该都是一样了）。

GRCh38是2013年12月发布的最新版本。hg和GRC略有不同，具体来说，hg19和GRCh37之间，染色体标号不一样，hg19使用带前缀的染色体标号chr1，chr2，……，而GRC用1,2，……来表示，所以做比对时，两个比对到两个基因组上的BAM文件是不能混用的。不过，同一个染色体上，GRCh37和hg19之间的坐标是一样的。

hg19主要用来做生物信息学分析，所以只包括染色体1~22+XY+线粒体，一些其它[Contig](url=https://en.wikipedia.org/wiki/Contig)就省略了。

hg38和GRCh38之间比较统一，染色体标号是一致的，而且包含的序列的数目也一样（不过为了生物信息学软件处理方便，NCBI和UCSC也提供一些阉割的基因组版本，具体看[这里](url=http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/analysisSet/)）。

hg38相比于hg19有哪些提高，主要如下

 - hg38包含了几百个alternate loci，比如6号染色体MHC区域，高度可变，每个人都不一样（除了同卵双胞胎），只在基因组里放一种序列就不太合理了
 - hg38着丝粒区域序列和线粒体序列得到了更新
 - hg38更正了hg19中已知的错误，比如有的基因开放阅读框（ORF）起始和终止位置不对，有的Aåº该是T（要不然编码的蛋白错误）。

### 3.2 Long Ranger 相关软件安装

解压下载好的软件及参考基因组hg19：

```
$ tar -xzvf longranger-2.1.1.tar.gz
$ tar -xzvf refdata-hg19-2.1.0.tar.gz
```

编辑`.bashrc`文件，并将Long Ranger路径加入环境变量，例如加入：

```
PATH=/path/to/longranger-2.1.1:$PATH
```

然后重新载入环境变量：`source ~/.bashrc`

可以使用以下命令检验安装是否正确：

```
longranger sitecheck
```

## 参考文献

 1. [http://support.10xgenomics.com/genome-exome/software/pipelines/latest/installation](http://support.10xgenomics.com/genome-exome/software/pipelines/latest/installation)
