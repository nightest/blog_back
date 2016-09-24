---
layout: post
title: 常用分析方法bam2fastq、blastn、trimmomatic
category: bioinformatics
tags: [bioinfo, linux, blastn, trim]
notebook: bioinfo
---

@Date: 2016-09-05 10:27:40

--------

* content
{:toc}

---------


## 1. bam转换为fastq

使用**bam2fastq**，**ion平台**的测序数据一般为bam文件，包含与参考基因组的比对结果，可以使用**samtools**查看。不过对于宏基因组测序来说，因为不存在参考基因组，因此没有任何map结果，可以直接转为fq文件也不会损失任何信息。

```
bam2fastq ./path/to/<name>.bam -o path/to/<name>.fastq
```

## 2. blast 比对

这里提到的是**BLAST+**。

blastn用于碱基序列之间的比对，一般只适用于少量序列与参考序列的比对。

一般情况下建立索引比较慢，但是建立好索引之后可以多次使用，比对速度适中, 比对结果准确。

```
blastn -query ./path/to/query.fasta  -out  /output/to/<name>.blast  -db ~/database/blast/db/16SMicrobial/16SMicrobial<已建好索引的参考库> -outfmt 6 -evalue 1e-10 -num_alignments 1 -num_threads 60
```

### 2.1 数据库索引

```
makeblastdb -in db.fasta -dbtype prot -parse_seqids -out dbname
参数说明:
-in：待格式化的序列文件
-dbtype：数据库类型，prot或nucl
-out：数据库名
```

### 2.2 蛋白序列比对蛋白数据库（blastp）

```
blastp -query seq.fasta -out seq.blast -db dbname -outfmt 6 -evalue 1e-5 -num_descriptions 10 -num_threads 8
参数说明:
-query： 输入文件路径及文件名
-out：输出文件路径及文件名
-db：格式化了的数据库路径及数据库名
-outfmt：输出文件格式，总共有12种格式，6是tabular格式对应BLAST的m8格式
-evalue：设置输出结果的e-value值
-num_descriptions：tabular格式输出结果的条数
-num_threads：线程数
```

### 2.3 核酸序列比对核酸数据库（blastn）以及核酸序列比对蛋白数据库（blastx）

与上面的blastp用法类似：

```
blastn -query seq.fasta -out seq.blast -db dbname -outfmt 6 -evalue 1e-5 -num_descriptions 10 -num_threads 8
blastx -query seq.fasta -out seq.blast -db dbname -outfmt 6 -evalue 1e-5 -num_descriptions 10 -num_threads 8
```

## 3. trimmomatic序列质控与过滤（filter and trim）

使用实例：

```
java -jar /soft/Trimmomatic-0.36/trimmomatic-0.36.jar PE -threads 10 -phred33 $m $n ../../trimmomatic/$m.cl ../../trimmomatic/$m.un ../../trimmomatic/$n.cl ../../trimmomatic/$n.un LEADING:3 TRAILING:3 SLIDINGWINDOW:36:10 MINLEN:75
```

### 3.1 trimmomatic 下载安装

下载地址：[http://www.usadellab.org/cms/?page=trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic)

安装好该软件后记得加入环境变量**PATH**~~

### 3.2 使用说明

我使用的是**0.36版**，其使用说明如下：

```
$ java -jar ~/bioSoft/Trimmomatic-0.36/trimmomatic-0.36.jar -h
Usage:
       PE [-version] [-threads <threads>] [-phred33|-phred64] [-trimlog <trimLogFile>] [-quiet] [-validatePairs] [-basein <inputBase> | <inputFile1> <inputFile2>] [-baseout <outputBase> | <outputFile1P> <outputFile1U> <outputFile2P> <outputFile2U>] <trimmer1>...
   or:
       SE [-version] [-threads <threads>] [-phred33|-phred64] [-trimlog <trimLogFile>] [-quiet] <inputFile> <outputFile> <trimmer1>...
   or:
       -version
```

其中：

#### 3.2.1 PE

双端数据

```
-threads：后面加数字表示使用线程数，可不设置，程序会自行检测并选择核心数（good）
-phred33或-phred64：表示质量值得格式，illumina 一般设置为-phred33格式，也可不设置，软件本身会自行确定，只是需要1min时间
../good\_1.fq ../good\_2.fq ：两个输入文件 (注意,给相对或者绝对路径)
pa_forward_paired.fq pa_forward_unpaired.fq ：forword的两个输出文件
pa_reverse_paired.fq pa_reverse_unpaired.fq ：reverse的两个输出文件
#输入文件和输出文件都支持gz等压缩格式，可以直接输入输出压缩文件。输出文件还要自己直接给名字，但也可以用-basein -baseout参数减少输入

ILLUMINACLIP:/path/to/adapter.fa:2:30:10
 - ILLUMINACLIP这个参数后面跟着接头文件
 - 2：接头匹配到读段,最多两个mismatch
 - 30：palindrome模式下匹配碱基数阈值 请见本文最后
 - 10：simple模式下的匹配碱基数阈值 关于模式，请自行查文献

LEADING:3 ：切掉5端碱基质量小于3的碱基
TRAILING:3 ：切掉3端碱基质量小于3的碱基
SLIDINGWINDOW:4:15 ：以4个碱基为宽度滑动，平均碱基质量低于15的，切掉
CROP:<length> ：Cut the read to a specified length by removing bases from the end 保留reads到指定的长度（应该是从末端切）
HEADCROP:<length> ： 在reads的首端切除指定的长度
MINLEN:50 ：短于50bp的reads，去掉remove
TOPHRED33 ： 将碱基质量转换为pred33格式
TOPHRED64 ： 将碱基质量转换为pred64格式
AVGQUAL: 去除平均质量值小于给定阈值的reads
```

tips:

 1. 此程序进行质控先后是按照给定参数的顺序进行的，推荐先进行adapter的去除,即第一使用的参数ILLUMINACLIP
 2. 支持直接对.gz/.bz2等压缩文件进行操作

## 4. 附属说明


### 4.1 blast输出格式说明

有时候根据不同的需要，输出不同的比对格式文件，格式说明如下：

```
 -outfmt <String>
   alignment view options:
     0 = pairwise,
     1 = query-anchored showing identities,
     2 = query-anchored no identities,
     3 = flat query-anchored, show identities,
     4 = flat query-anchored, no identities,
     5 = XML Blast output,
     6 = tabular,
     7 = tabular with comment lines,
     8 = Text ASN.1,
     9 = Binary ASN.1,
    10 = Comma-separated values,
    11 = BLAST archive format (ASN.1)

   Options 6, 7, and 10 can be additionally configured to produce
   a custom format specified by space delimited format specifiers.

   The supported format specifiers are:

           qseqid means Query Seq-id
              qgi means Query GI
             qacc means Query accesion
          qaccver means Query accesion.version
             qlen means Query sequence length
           sseqid means Subject Seq-id
        sallseqid means All subject Seq-id(s), separated by a ';'
              sgi means Subject GI
           sallgi means All subject GIs
             sacc means Subject accession
          saccver means Subject accession.version
          sallacc means All subject accessions
             slen means Subject sequence length
           qstart means Start of alignment in query
             qend means End of alignment in query
           sstart means Start of alignment in subject
             send means End of alignment in subject
             qseq means Aligned part of query sequence
             sseq means Aligned part of subject sequence
           evalue means Expect value
         bitscore means Bit score
            score means Raw score
           length means Alignment length
           pident means Percentage of identical matches
           nident means Number of identical matchesq
         mismatch means Number of mismatches
         positive means Number of positive-scoring matches
          gapopen means Number of gap openings
             gaps means Total number of gaps
             ppos means Percentage of positive-scoring matches
           frames means Query and subject frames separated by a '/'
           qframe means Query frame
           sframe means Subject frame
             btop means Blast traceback operations (BTOP)
          staxids means Subject Taxonomy ID(s), separated by a ';'
        sscinames means Subject Scientific Name(s), separated by a ';'
        scomnames means Subject Common Name(s), separated by a ';'
       sblastnames means Subject Blast Name(s), separated by a ';'
                (in alphabetical order)
       sskingdoms means Subject Super Kingdom(s), separated by a ';'
                (in alphabetical order)
           stitle means Subject Title
       salltitles means All Subject Title(s), separated by a '<>'
          sstrand means Subject Strand
            qcovs means Query Coverage Per Subject
          qcovhsp means Query Coverage Per HSP
```

此时可以根据上面的格式说明自定义输出项，自定义方式如下：

```
 blastn -query tmp.fasta -out tmp.blast -db ~/database/blast/db/16SMicrobial/16SMicrobial -evalue 1e-10 -num_alignments 1 -num_threads 60 -outfmt "6 qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore"
```

**""**中的内容即自定义的输出内容。
