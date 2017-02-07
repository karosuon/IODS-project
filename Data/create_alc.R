#Karoliina Suonpää, 7.2.2017
#RStudio Exercise 3, data wrangling (data: UCI Machine Learning Repository, Student Alcohol consumption) 

#set workind directory
setwd("Z:/Jatko-opinnot/Tilastotiede 2016/IODS/IODS-project/Data") 

#check working directory
getwd()

#read the data from portuguese class
por<-read.csv("student-por.csv", sep=";", header=T) 

#read the data from math class
mat<-read.csv("student-mat.csv", sep=";", header=T)

#check the datasets
summary(por)
str(por)
dim(por)
summary(mat)
str(mat)
dim(mat)

#Join the two datasets 
# access the dplyr library
library(dplyr)

#join the mat and por data frames
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
mat_por <- inner_join(mat, por, by = join_by, suffix=c(".mat", ".por"))

# see the new column names
colnames(mat_por)

# check the new dataset
glimpse(mat_por)
str(mat_por)
dim(mat_por)

# create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(mat)[!colnames(mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
###  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)
dim(alc)
summary(alc)

#Everything seems OK

#Take the average of the answers related to weekday and weekend alcohol consumption to create a new column
#'alc_use' to the joined data. 
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#'Then use 'alc_use' to create a new logical column 'high_use' which is TRUE for students for which 'alc_use' is 
#'#greater than 2 (and FALSE otherwise).
alc <- mutate(alc, high_use = alc_use > 2)

#check the new variable
summary(alc$high_use)

#check the new combined dataset
dim(alc)
glimpse(alc)
summary(alc)

# Write CSV in and save to the Data-folder
write.csv(alc, file = "alc.csv")

#check that everything is OK
read.table("alc.csv", sep=",", header=T)
summary(read.table("alc.csv", sep=",", header=T))
