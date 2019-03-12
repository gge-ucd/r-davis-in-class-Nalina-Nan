# welcome to week 9!

#Reviewing Homework from Week 8

library(lubridate)
library(tidyverse)

#Part 1

am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)

am_riv$datetime <- paste(am_riv$Date, " ", am_riv$Time, sep = "")
glimpse(am_riv) #pasting the date and time columns together

am_riv$datetime <- ymd_hms(am_riv$datetime) #making the new column a datetime datatype

#new column for week
am_riv$wk <- week(am_riv$datetime)

View(am_riv)
#calculating mean, min, and max weekly temps
am_riv2 <- am_riv %>% 
  group_by(wk) %>% 
  summarize(mean_wk = mean(Temperature), min_wk = min(Temperature), max_wk = max(Temperature))

glimpse(am_riv2)

#plotting mean, min and max temperatures on the same graph
am_riv2 %>% 
  ggplot()+
  geom_point(aes(x=wk, y = mean_wk), color = "blue")+
  geom_point(aes(x=wk, y = min_wk), color = "red")+
  geom_point(aes(x=wk, y = max_wk), color= "green")+
  xlab("Week Number")+ ylab("Temperature")+
  theme_bw()

#making new columns for hour and month 
am_riv$hourly <- hour(am_riv$datetime)
am_riv$month <- month(am_riv$datetime)

#finding the mean hourly level for April through June
am_riv3 <- am_riv %>% 
  filter(month == 4 | month == 5 | month == 6) %>% 
  group_by(hourly, month, datetime) %>% 
  summarize(mean_level = mean(Level))

#plotting the mean level from April through June 
am_riv3%>% 
  ggplot()+
  geom_line(aes(x=datetime, y = mean_level), color = "blue") +
  ylim(1.1, 1.9)+
  theme_bw()



####Part 2#### 

load("data/mauna_loa_met_2001_minute.rda")

#making datetime column 
mloa_2001$datetime <- paste0(mloa_2001$year, "-", mloa_2001$month, "-", mloa_2001$day, " ", mloa_2001$hour24, ":", mloa_2001$min)

glimpse(mloa_2001)

#putting it in datetime format
mloa_2001$datetime<- ymd_hm(mloa_2001$datetime)  

#removing the NAs
mloa2 <- mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m!= -99, temp_C_2m != -999) %>% 
  filter(windSpeed_m_s!= -99, windSpeed_m_s != -999)

#writing the function 

plot_temp <- function(monthtoimput, dat = mloa2){
  df <- filter(dat, month == monthtoimput)
  plot <- df %>% 
    ggplot()+ geom_line(aes(x=datetime, y = temp_C_2m), color = "red")+
    theme_bw()
  return(plot)
}

#testing the function, should get a plot for just March temperatures 
plot_temp(2)




# Back to Iteration -------------------------------------------------------

# first argument is the data/thing you ant to iterate ACROSS. and the second argument is the function you want to APPLY to each thing
sapply(1:10,sqrt)
sqrt(1:10)

#for loop first... make result first
result <- rep (NA,10) #replete NA 10 times
for (i in 1:10) {
  result[i]<- sqrt(i)/2
}
result

#now to use sapply same as for loop, but cleaner
result_apply<-sapply(1:10, function(x) sqrt(x)/2)

#anonemous funcition

#additonal arguaments in apply

mtcars_na <- mtcars

mtcars_na [1,1:4] <- NA
sapply(mtcars_na, mean)

sapply(mtcars_na, mean, na.rm=T)
#remove NA

#same as 
mean (mtcars_na$hp,na.rm=T)

#back to tidyverse
#map_

mtcars %>% 
  map_dbl(mean)

#get back charactor
mtcars %>% 
  map_chr(mean)

#map2_ for two sets of inputs

map2_chr(rownames(mtcars),mtcars$mpg, function (x,y) paste(x,"gets",y,"miles per gallon"))


#complete workflow
#attempt to scale our weights of mtcars
#rescale data

(mtcars$wt[1]-min(mtcars$wt))/(max(mtcars$wt)-min(mtcars$wt))


#generalize
(x-min(x))/(max(x)-min(x))

rescale_01<- function (x) {
  (x-min(x))/(max(x)-min(x))
}
rescale_01(mtcars$wt)


#iterating

map(mtcats)

map_df(mtcars,rescale_01)
#so coooooool: rescale in each column



# Markdown ----------------------------------------------------------------


