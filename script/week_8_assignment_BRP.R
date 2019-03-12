library(tidyverse)
library(lubridate)

am_riv <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/2015_NFA_solinst_08_05.csv", skip = 13)

#should have a data frame with 35,038 obs of 5 variables

### Park 1 ####

#Make a datetime column by using paste to combine the date and time columns; remember to convert it to a datetime!
#Calculate the weekly mean, max, and min water temperatures and plot as a point plot (all on the same graph)
#Calculate the hourly mean Level for April through June and make a line plot (y axis should be the hourly mean level, x axis should be datetime

am_riv$datetime <- as.POSIXct(paste(am_riv$Date, am_riv$Time))

# new column for week 
am_riv$wk <- week(am_riv$datetime)

# calculate mean, min, and max weekly temps 
am_riv2 <- am_riv %>% 
  group_by(wk) %>% 
  summarize(mean_wk = mean(Temperature), min_wk = min(Temperature), max_wk = max(Temperature))

glimpse(am_riv2)

# plot mean, min, max
am_riv2 %>% 
  ggplot() +
  geom_point(aes(x=wk, y = mean_wk), color = "blue") +
  geom_point(aes(x = wk, y = min_wk), color = "red") +
  geom_point(aes(x = wk, y = max_wk), color = "green") +
  xlab("Week") + ylab("Temperature") + theme_classic()

# make new columns for hours and month 
am_riv$hourly <- hour(am_riv$datetime)
am_riv$month <- month(am_riv$datetime)


# find mean hourly level for April through June 
am_riv3 <- am_riv %>% 
  filter(month == 4 | month == 6) %>% 
  group_by(hourly, month, datetime) %>% 
  summarize(mean_level = mean(Level))

# plot mean level 
am_riv3 %>% 
  ggplot() +
  geom_point(aes(x=datetime, y = mean_level)) +
  ylim(1.1,1.9) + theme_classic()


### Part 2 ####

#Use the mloa_2001 data set (if you don’t have it, download the .rda file from the resources tab on the website). Remeber to remove the NAs (-99 and -999) and to create a datetime column (we did this in class).

#Then, write a function called plot_temp that returns a graph of the temp_C_2m for a single month. The x-axis of the graph should be pulled from a datetime column (so if your data set does not already have a datetime column, you’ll need to create one!)


mloa_2001$datetime<- ymd_hm(mloa_2001$datetime)
mloa2 <- mloa_2001 %>% 
  filter(rel_humid != -99, rel_humid != -999) %>% 
  filter(temp_C_2m!= -99, temp_C_2m != -999) %>% 
  filter(windSpeed_m_s!= -99, windSpeed_m_s != -999)

plot_temp <- function(singlemonth, dat = mloa2){
  df <- filter(dat, month == singlemonth)
  plot <- df %>% 
    ggplot() + geom_line(aes(x=datetime, y = temp_C_2m)) + theme_classic()
  return(plot)
}

# test the function for April (month 4)

plot_temp(4)
 # it works! 