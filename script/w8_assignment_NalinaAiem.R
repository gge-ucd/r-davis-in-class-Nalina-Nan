
# PART 1 ------------------------------------------------------------------


library(tidyverse)
library(lubridate)
am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)

#should have a data frame with 35,038 obs of 5 variables

#Make a datetime column by using paste to combine the date and time columns; remember to convert it to a datetime!

#add date time column 
am_riv$dateTime<-paste(am_riv$Date," ",am_riv$Time,sep="")

#convert ti a datetime type 

am_riv$dateTime<-ymd_hms(am_riv$dateTime,tz="America/Los_Angeles")

View(am_riv)

#Calculate the weekly mean, max, and min water temperatures and plot as a point plot (all on the same graph)

#not sure how to calculate weekly
#print(difftime(max(am_riv$Date),min(am_riv$Date),units = "week"))
#Week <- function(a=min(am_riv$Date),b=max(am_riv$Date)) { 
#Week=seq(min(am_riv$Date),to=max(am_riv$Date),  by="week")
#return()


am_riv1<-am_riv %>% 
  mutate(which_week = week(dateTime),label=TRUE) %>% 
  group_by(which_week) %>% 
  summarize(mean_water = mean (Temperature),min_water = min (Temperature),max_water = max(Temperature))

#problem: the first week of data collection is not week 1

am_riv1 %>% 
  ggplot ()+
  geom_point(aes(x=which_week,y=mean_water,col='green'),alpha=0.8)+
  geom_point(aes(x=which_week,y=min_water,col='orange'),alpha=0.8)+
  geom_point(aes(x=which_week,y=max_water,col='blue'),alpha=0.8)+
  labs(title="water temperature in a year", x="week of the year", y="water temperature")

  #should add legend label but dont know how


#Calculate the hourly mean Level for April(4) through June(6) and make a line plot (y axis should be the hourly mean level, x axis should be datetime)

am_riv2<-am_riv %>% 
  mutate(which_month = month(Date)) %>% 
  mutate(which_hour = hour(Time)) %>% 
  filter(which_month>3&which_month<7) %>% 
  group_by(which_hour) %>% 
  summarize(mean_level = mean (Level))


am_riv2 %>% 
  ggplot ()+
  geom_line(aes(x=which_hour,y=mean_level),col='salmon',alpha=0.8,size=2)+
  labs(title="hourly mean Level for April through June", x="hour", y="hourly mean water temperature")


# PART 2 ------------------------------------------------------------------

load("data/mauna_loa_met_2001_minute.rda")
mloa_2001$datetime<-paste0(mloa_2001$year,"-",mloa_2001$month,"-",mloa_2001$day," ", mloa_2001$hour24,":",mloa_2001$min)
mloa_2001$datetime<-ymd_hm(mloa_2001$datetime)

mloa2<-mloa_2001 %>% 
  filter(rel_humid!=-99,rel_humid!=-999) %>% 
  filter(temp_C_2m!=-99,temp_C_2m!=-999) %>% 
  filter(windSpeed_m_s!=-99,windSpeed_m_s!=-999)

#Then, write a function called plot_temp that returns a graph of the temp_C_2m for a single month. The x-axis of the graph should be pulled from a datetime column

plot_temp<- function(monthToPlot, dat=mloa2){
  new<-filter(dat, month == monthToPlot)
  plot<-ggplot(new,aes(x=datetime,y=temp_C_2m))+
    geom_line(col="salmon")
  return(plot)
}

#test
plot_temp(3)


