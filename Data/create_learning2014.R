#Karoliina Suonp‰‰, 2.2.2017
#Data Wrangling

#read the data
mydata <- read.csv("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=T)

#see the summary of the data
summary(mydata)
str(mydata)
dim(mydata)
head(mydata)

#everything looks OK

#create combined variables of Deep approach
mydata$d_sm <- mydata$D03 + mydata$D11 + mydata$D19 + mydata$D27
mydata$d_ri <- mydata$D07 + mydata$D14 + mydata$D22 + mydata$D30
mydata$d_ue <- mydata$D06 + mydata$D15 + mydata$D23 + mydata$D31
mydata$deep <- mydata$d_sm + mydata$d_ri + mydata$d_ue
mydata$deep_adjusted <- mydata$deep/12

#create combined variables of Strategic approach
mydata$st_os <- mydata$ST01 + mydata$ST09 + mydata$ST17 + mydata$ST25
mydata$st_tm <- mydata$ST04 + mydata$ST12 + mydata$ST20 + mydata$ST28
mydata$stra <- mydata$st_os + mydata$st_tm
mydata$stra_adjusted <- mydata$stra/8

#create combined variables of Surface approach
mydata$su_lp <- mydata$SU02 + mydata$SU10 + mydata$SU18 + mydata$SU26
mydata$su_um <- mydata$SU05 + mydata$SU13 + mydata$SU21 + mydata$SU29  
mydata$su_um <- mydata$SU08 + mydata$SU16 + mydata$SU24 + mydata$SU32
mydata$surf <- mydata$su_lp+mydata$su_um+mydata$su_um
mydata$surf_adjusted <- mydata$surf/12

#check the data again
summary(mydata)

#create a subset
#install and access the package
install.packages("dplyr")
library(dplyr)

## select the variables gender, age, attitude, deep, stra, surf and points 
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
new_data <- select(mydata, one_of(keep_columns))

#exclude observations
new_data <-filter(new_data, Points>0)

#see that filtering worked OK
summary(new_data$Points)

#check the new data one more time
summary(new_data)
str(new_data)
View(new_data)

#everything looks OK

#set working directory
setwd("F:/IODS")
getwd()

#learn how to use write.csv-function
?write.csv
?read.csv

# Write CSV in R
write.csv(new_data, file = "learning2014.csv")

#read the data from working directory
new_data2 <- read.csv("learning2014.csv", sep=",", header=T)
