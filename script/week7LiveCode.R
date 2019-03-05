#week 7 Live code

#how to install the package from GitHub (normally in Cran)
#install.packages("devtools")

devtools::install_github("thomasp85/patchwork")

####Data import and export####

library(tidyverse)

wide_data <-read_csv("data/wide_eg.csv", skip = 2)
#skip to ignore the first 2 rows


#rds = single R onject, rda store multiple R objects

load("data/mauna_loa_met_2001_minute.rda")

#write wide_data to an RDS file
saveRDS(wide_data,"data/wide_data.rds")

rm(wide_data) # remove object from env.

wide_data_rds<-readRDS("data/wide_data.rds") #~read_csv, onlt works with R
#use RDS with model, compress, smaller than CSV

#saveRDS() and readRDS () for .rds files, and we use save() and load () for .rda files

#other packages: readxl:: #read several sheets , googlesheets, and googledrive, foreign 

#foreign:: read weird surname

install.packages("rio")
library (rio) #import weird kind of data without download the package

rio::import("data/wide_data.rds")


# working with Dates and times --------------------------------------------

library(lubridate)

#3 basuc classes of dates in R

#Dates: just date
#POSIXct: time in computer *more common
#POSIXlt: local time pull out into list

sample_date1<-c("2016-02-01","2016-03-17","2017-01-01")
as.Date(sample_date1)
#looking for data that looks like yyyy-mm-dd

sample_date2<-c("02-01-2001","04-04-1991")
sample_date2<-as.Date(sample_date2, format = "%m-%d-%y")
#capital - 2 digit VS 1
#Upper case Y = yyyy, lower case y = yy

#weird, have to tell the format


as.Date("2016/01/01",format = "%Y/%m/%d")

as.Date("July 04, 2017",format = "%B%d,%Y")
#b - shorten month, B-full month

?strptime

#Date Calculation

dt1<-as.Date("2017-07-11") #correct pattern, does not have to specify a format

dt2<-as.Date("2016-04-22")

print(dt1-dt2) #difference in days

print(difftime(dt1,dt2,units = "week"))

six.weeks<-seq(dt1, length =6, by="week") # 1 week interval

#create a sequence of 10 dates starting at dt1 with 2 week intervals

seq(dt1, length =10, by=14 )

seq(dt1, length =10, by="2 week")

#easy way


ymd("2016/01/01")

dmy("04.04.91")

mdy("Feb,19,2005")


#git disappear 

#terminal - which git , copy path
#R studio - tool, global option, git paste


