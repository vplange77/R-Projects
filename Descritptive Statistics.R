#Assignment 1 (Intermediate Analytics)

#Question1
#Set working directory
getwd()
setwd("//Users/victoriaplange/Downloads")

#Load external dataset
dta1 <- read.csv("assignment1.csv")
dta1 <- data.frame(dta1)
summary(dta1)
names(dta1)
sd(dta1$Sepal.Width)
library(ggplot2)

ggplot(data=dta1) + 
geom_histogram(mapping=aes(x=Sepal.Width), binwidth=.1)



#Question 2
#Plot histogram of men's and women's height
#Load external dataset
dta3 <- read.csv("height_weight_by_gender.csv")
dta3 <- data.frame(dta3)
summary(dta3)
names(dta3)
ggplot(data=dta3) + 
geom_histogram(mapping=aes(x= Height..inches., fill=Gender),bins=23, position="dodge") +
  scale_x_continuous(limits=c(40,100))


#Question 3
#plot scatterplot for height by weight for women
summary(dta3)
names(dta3)
ggplot(data=dta3, aes(x=Weight..lbs., y=Height..inches.)) +
geom_point(size=2) + geom_abline()



