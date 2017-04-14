---
title: "Orange Tree Study"
author: "Laurie Harris"
date: "April 13, 2017"
output: html_document
---



##Introduction

There is a data file available in R which contains circumference measurements for five orange trees.  These measurements are identified by age of the tree in days from a baseline date.  This analysis will show the circumference measurement changes over a timeframe of 1582 days beginning on December 31, 1968 and a final measurement on day 1582 or May 1, 1973.

##Data Gathering
The data can be obtained very simply by calling the dataframe, Orange, from the R console.

```r
#Orange Data Gathering
#Assign the Orange dataset in R to the object orange.
#Attach object orange for use in subsequent data analysis.
##Data content:  
##The Orange data set contains 35 observations with 3 columns.  
##Tree is a factor, identifying a particluar tree, 
##Age is number of days from 12/31/1968, and 
##Circumference is numeric value measured in mm.
orange <- Orange
attach (orange)
```

```
## The following objects are masked from orange (pos = 7):
## 
##     age, circumference, Tree
```

##Data Analysis
We would like to understand more about the circumferences of each tree therefore we will compute the mean and median circumferences from the measurement data.

```r
#Calculate mean and median of the trunk circumferences by Tree
#install "plyr" and "pander" packages if not installed
#install.packages ("plyr")
#install.packages ("pander")
#invoke libraries
library(plyr)
library(pander)
#Compute mean circumference by Tree
mean <- ddply(orange, .(Tree), summarize, mean=mean(circumference))
mean$mean <- format(mean$mean,digits = 2)
sortmean <- format(mean[order(as.character(mean$Tree)),],2)
#Compute median circumference by Tree
median <- ddply(orange, .(Tree), summarize, median=median(circumference))
sortmedian <- median[order(as.character(median$Tree)),]
#Merge table and display results
meanmed <- merge(x=sortmean, y=sortmedian, by="Tree")
pander(meanmed)
```


----------------------
 Tree   mean   median 
------ ------ --------
  1     100     115   

  2     135     156   

  3      94     108   

  4     139     167   

  5     111     125   
----------------------

##Graphical Examination
To demonstrate the differences in circumferences over the timeframe, we will present two plots that show the data for each tree.  The first plot shows the circumference change over time for each tree.  The second plot shows the range of circumference change as separate boxplots for each tree.  

```r
#Create plots
#Scatterplot of tree age vs. circumference
#install ggplot2 if not already installed
#install.packages("ggplot2")
#invoke library
library(ggplot2)
scatter <- ggplot(orange, aes(age,circumference)) + geom_point(aes(color=Tree, shape=Tree)) + xlab("Age (in days from 12/31/1968)")+ ylab("Circumference (mm)")
scatter
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png)

```r
#Boxplot of tree circumferences by Tree
box <- ggplot(orange, aes(Tree,circumference))+geom_boxplot()
box
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-2.png)

##Conclusion
In each of the displays, we notice that tree number 4 has the highest mean and median circumferences and tree number 3 has the lowest mean and median circumferences.  The range circumferences of trees 1 and 3 appear to be similar, on a smaller scale, while trees 2 and 4 appear to share similar, larger circumference ranges.