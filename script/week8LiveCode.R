library(lubridate)
library(tidyverse)

load("data/mauna_loa_met_2001_minute.rda")
#use load for .rda

as.Date("02-08-1991",format="%m-%d-%Y")


mdy("02-01-1998")

#class date time data
#y-m-d-h-m-s
tm1<-as.POSIXct("2016-02-24 23:55:21 PDT")

tm2<-as.POSIXct("25072016 08:22:07", format="%d%m%Y %H:%M:%S")

tm3 <- as.POSIXct("2010-12-21 11:42:03", tz = "GMT")

#specify timezone and date format in the same call

tm4<- as.POSIXct(strptime("2016/04/04 14:47", format = "%Y/%m/%d %H:%M"), tz = "America/Los_Angeles")

as.POSIXct(strptime("2016/04/04 14:47", format = "%Y/%m/%d, %H:%M"), tz="America/Los_Angeles")

tz(tm4)

Sys.time()


ymd_hm("2016/04/04 14:47", tz = "America/Los_Angeles")

ymd_hms("2016-05-04 22:14:11",tz = "GMT")

nfy1 <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFY_solinst.csv", skip = 12)

nfy2 <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFY_solinst.csv", skip = 12, col_types = "ccidd")
#charactor,charactor,integer,decimal,decimal

glimpse(nfy)

nfy3 <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFY_solinst.csv", skip = 12, col_types = cols(.default="c",Level = "c"))

nfy4 <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFY_solinst.csv", skip = 12, col_types = cols(Date = col_date()))
glimpse(nfy4)
#read everything as normal, but just read the column date as a different thing


#paste column together
 
nfy2$datetime<-paste(nfy2$Date," ",nfy2$Time,sep = "")
?paste

nfy$datetime_test<-ymd_hms(nfy2$datetime,tz="America/Los_Angeles")

glimpse(nfy)

tz(nfy$datetime_test)


nfy$datetime<-ymd_hms(nfy2$datetime,tz="America/Los_Angeles")


summary(mloa_2001)

mloa_2001$datetime<-paste0(mloa_2001$year,"-",mloa_2001$month,"-",mloa_2001$day," ", mloa_2001$hour24,":",mloa_2001$min)

glimpse(mloa_2001)

mloa_2001$datetime<-ymd_hm(mloa_2001$datetime)

#Remove the NA’s (-99 and -999) in rel_humid, temp_C_2m, windSpeed_m_s

mloa2<-mloa_2001 %>% 
  filter(rel_humid!=-99,rel_humid!=-999) %>% 
  filter(temp_C_2m!=-99,temp_C_2m!=-999) %>% 
  filter(windSpeed_m_s!=-99,windSpeed_m_s!=-999)

View(mloa_2001)

#Use dplyr to calculate the mean monthly temperature (temp_C_2m) using the  datetime column (HINT: look at lubridate functions like month())

#create the new column with only month
mloa3<-mloa2%>% 
  mutate(which_month = month(datetime,label=TRUE)) %>% 
  group_by(which_month) %>% 
  summarize(aver_temp = mean (temp_C_2m))


#if want to combine.. use mutate
glimpse(mloa3)

#aes only x and y, not size
mloa3 %>% 
  ggplot()+
  geom_point(aes(x=which_month, y=aver_temp),size=3,color="Tomato") +
  geom_line(aes(x=which_month, y=aver_temp,group=1))




# FUNCTIONS ---------------------------------------------------------------

log(5)

#function can return what you want

my_sum <- function(a=1,b=2) { #default
  the_sum<-a+b
  return(the_sum)
}

my_sum(2,4)

my_sum()

#Create a function that converts the temp in K to the temp in C (subtract 273.15)

ConvertKtoC<-function(K){
  C<-K-273.15
  return(C)
}

ConvertKtoC(500)



####Iteration

x<-1:10
log(x)

  
#for loop: repeat some bit of code with some new value

for (i in 1:10){
  print(i)
}
for (i in 1:10){
  print(i)
  print(i^2)
}


letters[2]

#we can use the i value as an index



for (i in 1:10) {
  print(letters[i]) #index
  print(mtcars$wt[i])
}

#store result somewhere, create a container to hold the result before running the loop

#should let R know how big it should create the container first

results<-rep(NA,10)

for (i in 1:10){
  results[i] <-letters [i]
}

results
