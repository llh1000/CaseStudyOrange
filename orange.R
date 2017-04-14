# Call Orange data set in R
# The Orange data set contains 35 observations with 3 columns.  Tree is a factor, identifying 
#a particluar tree, Age is number of days from 12/31/1968 and Circumference is numeric value 
#measured in mm.
orange <- Orange
#attach orange for reference for addtional analysis
attach (orange)
#calculate mean and median of the trunk circumferences by Tree
#install "plyr" package if not installed
#install.packages ("plyr")
#invoke library plyr
library(plyr)
library(pander)
#compute mean circumference by Tree and sort
mean <- ddply(orange, .(Tree), summarize, mean=mean(circumference))
mean$mean <- format(mean$mean,digits = 2)
sortmean <- format(mean[order(as.character(mean$Tree)),],2)
#compute median circumference by Tree and sort
median <- ddply(orange, .(Tree), summarize, median=median(circumference))
sortmedian <- median[order(as.character(median$Tree)),]
#merge table for display
meanmed <- merge(x=sortmean, y=sortmedian, by="Tree")
pander(meanmed)

#TODO: add title to table, change col names, export table and include in report

#scatterplot of tree age vs. circumference
#install ggplot2 if not already installed
#install.packages("ggplot2")
library(ggplot2)
scatter <- ggplot(orange, aes(age,circumference)) + geom_point(aes(color=Tree, shape=Tree)) + xlab("Age (in days from 12/31/1968)")+ ylab("Circumference (mm)")

#TODO: save plot as jpeg for report

#boxplot of tree circumferences
box <- ggplot(orange, aes(Tree,circumference))+geom_boxplot()

#TODO: save plot as jpeg for report