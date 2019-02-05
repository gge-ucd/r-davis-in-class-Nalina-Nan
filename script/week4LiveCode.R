#Git tab -> Pull


#intro to data frame

download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data/portal_data_joined.csv") #desfile = how to name it.csv

surveys <- read.csv(file = "data/portal_data_joined.csv")
#tab then " tab again

surveys #not easy to read

head(surveys,n = 10)

#data frame = several combinded vectors
#vectors = have to be the same type

#let's look at structure 

str(surveys)
dim(surveys)

nrow(surveys)
ncol(surveys)

tail(surveys)
names(surveys) #charactor vector
rownames(surveys)
colnames(surveys)

summary(surveys)

#subsetting dataframe

#subsetting vectors by givinh them a location index
animalVec<-c("mouse","rat","cat")
animalVec[2]
#dataframes are 2D

(surveys[2,1]) #[row,col]

#whole first column
is.vector(surveys[,1]) #give us a vector

surveys[1] #using a single number, with no comma, will give us a data frame with 1 column #behave differently 

#pull out the first three values in this specific column
surveys[1:3,6]

animalVec[c(1,3)] #as a vector


#you can put vector in the square blacket

#pull out a whole single observation
str(surveys[5,]) #data frame

#negative sign to exclude indices

surveys[1:5,-1]


surveys[-10:34786,] #: expand into a vector , not from -10

surveys[-c(10:34786),] #data frame

surveys [c(10,15,20,10),]

#more ways to subset
names(surveys) #charactor vector
surveys["day"] #got as data frame
surveys[,"day"] #got as vector
surveys[["day"]] #got as vector #use [[]] is list

surveys$hindfoot_length #single column as a vector



#data frame as a train, a car is column


#challenge
#1
surveys_200<- surveys[200,]

#2
(nrow(surveys))
surveys[nrow(surveys),] 
tail(surveys,1)
surveys_last<-surveys[nrow(surveys),]

#3
nrow(surveys)/2

#4
surveys_middle<-surveys[nrow(surveys)/2,]

#5
surveys[-c(7:nrow(surveys)),]

#Finally, factors
#factor stores as ingeter with lables assign to them, can be ordered or not

#carefull with their integer nature

surveys$sex

sex<-factor(c("male","female","female","male"))

sex #alphabetical, female=1, male=2

class(sex) #outside
typeof(sex) #fundamental #inside

levels(sex) #charactor vector
levels(surveys$genus)
#levels (gives back a charactor vectoe of the level)
nlevels(sex)

concentration <- c("high","medium","low")
str(concentration)
concentration<-factor(concentration,levels = c("low","medium","high"))
concentration

#let's try adding to a factor
concentration<-c(concentration,"very high")
concentration #nooooo

#let's make them charactors
as.character(sex) #level

year_factor<-factor(c(1990,1923,1965))
as.numeric(year_factor)
as.character(year_factor) #back to factor

as.numeric(as.character(year_factor))

#What all the factors?
?read.csv #string as factor, default = T
surveysNoFactors<-read.csv(file ="data/portal_data_joined.csv",stringsAsFactors = F)
str(surveysNoFactors)

#recommended way
as.numeric(levels(year_factor)) 

as.numeric(levels(year_factor))[year_factor]

#renaming factors
sex<-surveys$sex
levels(sex)
levels(sex)[1]<-"undetermined"
levels(sex)

#working with dates

#install.packages("lubridate")
library(lubridate)
my_date<-ymd("2015-01-01")

str(my_date)
#Git tab -> commit, push

my_date <-ymd(paste("2015","05","17", sep = "-")) #paste a bunch of value and stick them together
#do this to the entire column

paste(surveys$year,surveys$month,surveys$day,sep="-")

surveys$date<-ymd(paste(surveys$year,surveys$month,surveys$day,sep="-"))

surveys$date

surveys$date [is.na(surveys$date)]
