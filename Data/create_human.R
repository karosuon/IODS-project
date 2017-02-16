#RStudio Exercise 4, data wrangling (data: "Human development" and "Gender inequality", 
#more information here: http://hdr.undp.org/en/content/human-development-index-hdi) 

#set workind directory
setwd("Z:/Jatko-opinnot/Tilastotiede 2016/IODS/IODS-project/Data") 

#check working directory
getwd()

#read the data "Human development" 
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

#read the data "Gender inequality" 
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

#check the Human development dataset
dim(hd)
str(hd)
summary(hd)

#rename variables of the Human development dataset
names(hd)[names(hd)=="HDI.Rank"] <- "hdi_r"
names(hd)[names(hd)=="Country"] <- "country"
names(hd)[names(hd)=="Human.Development.Index..HDI."] <- "hdi_i"
names(hd)[names(hd)=="Life.Expectancy.at.Birth"] <- "life_exp" 
names(hd)[names(hd)=="Expected.Years.of.Education"] <- "educ_exp" 
names(hd)[names(hd)=="Mean.Years.of.Education"] <- "educ_mean" 
names(hd)[names(hd)=="Gross.National.Income..GNI..per.Capita"] <- "gni_c" 
names(hd)[names(hd)=="GNI.per.Capita.Rank.Minus.HDI.Rank"] <- "gni_hdi_dif" 

#check that renaming worked OK
names(hd)  


#check the Gender inequality dataset
dim(gii)
str(gii)
summary(gii)  

#rename variables of the Gender inequality dataset
names(gii)[names(gii)=="GII.Rank"] <- "gii_r"
names(gii)[names(gii)=="Country"] <- "country"
names(gii)[names(gii)=="Gender.Inequality.Index..GII."] <- "gii_i"
names(gii)[names(gii)=="Maternal.Mortality.Ratio"] <- "mat_mort"
names(gii)[names(gii)=="Adolescent.Birth.Rate"] <- "b_rate"
names(gii)[names(gii)=="Percent.Representation.in.Parliament"] <- "parl"
names(gii)[names(gii)=="Population.with.Secondary.Education..Female."] <- "educ_f"
names(gii)[names(gii)=="Population.with.Secondary.Education..Male."] <- "educ_m"
names(gii)[names(gii)=="Labour.Force.Participation.Rate..Female."] <- "labour_f"
names(gii)[names(gii)=="Labour.Force.Participation.Rate..Male."] <- "labour_m"

#check that renaming worked OK
names(gii)

#create new variable the ratio of Female and Male populations with secondary education in each country
gii$educ_rat <- gii$educ_f/gii$educ_m
summary(gii$educ_rat)

#create new variable the ratio of labour force participation of females and males in each country 
gii$labour_rat <- gii$labour_f/gii$labour_m
summary(gii$labour_rat)

#check that everything worked OK
summary(gii)

# access the dplyr library
library(dplyr)

# use the variable "country" as identifier
join_by <- c("country")

# join the two datasets by the selected identifiers
human <- inner_join(hd, gii, by = join_by)

# see the new column names
colnames(human)

# glimpse at the new data
glimpse(human)

#compare the three datasets
dim(human)
dim(hd)
dim(gii)

#Everythinig worked OK!

#Write CSV in and save to the Data-folder
write.csv(human, file = "human.csv")
