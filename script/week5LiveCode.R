#install.packages("tidyverse")
#access online data 

library(tidyverse)

#read_csv - string as factor = F by defalut. Function in tidy verse. read.csv default in R
surveys<-read_csv("data/portal_data_joined.csv")

#told to use read_csv in readr package.
#surveys<-readr::read_csv("data/portal_data_joined.csv")

str(surveys)
#chr never converted to factor

#select is used for columns in a data frame
names(surveys)
select(surveys, plot_id,species_id,weight)

#tab - looks for object... column name is not

#filter is used for selecting rows
filter(surveys, year == 1995)

surveys2 <- filter(surveys, weight < 5)

surveys_sml <- select(surveys2,species_id,sex,weight)

#tedious 

#pipe %>% on a PC ctr+shift+M, on Mac Command+shift+M
#what to the left of the pipe to the first slot of the thing on the right of the pipe
# pipe = then

surveys %>% 
  filter(weight<5) %>% 
  select(species_id,sex,weight)

##Challenge! Subset surveys to include individuals collected before 1995 and retain only the columns year, sex, and weight

challange<-surveys %>% 
  filter(year<1995) %>% 
  select(year,sex,weight)

#mutate is used to create new columns

#mutate (whatToCall = howToCompute)
surveys<-surveys %>% 
  mutate(weight_kg = weight/1000) %>% 
  mutate(weight_kg2 = weight_kg*2)

# a lot of NA

surveys %>% 
    filter(!is.na(weight)) %>%  #filtering out NAs
    mutate(weight_kg = weight/1000) %>% 
    summary()
    
#complete case to filter our all of the NAs


#challenge
#Create a new data frame from the surveys data that meets the following criteria: contains only the  species_id column and a new column called hindfoot_half containing values that are half the  hindfoot_length values. In this hindfoot_half column, there are no NAs and all values are less than 30.

surveys %>% 
  mutate(hindfoot_half = hindfoot_length/2) %>% 
  filter(!is.na(hindfoot_half)) %>% 
  filter(hindfoot_half<30) %>% 
  select(species_id,hindfoot_half)


#group by is good for split- apply-combine

#compute mean weight male and female

surveys %>% 
  group_by(sex) %>% 
  summarise(mean_weight=mean(weight,na.rm = TRUE))
#remove NA in weight
#summarize acts like a mutate
#summarize - work with the new data frame
#mutate - original data frame

surveys %>% 
  group_by(sex) %>% 
  mutate(mean_weight=mean(weight,na.rm = TRUE)) %>% 
  View

#mutate adds new columns to an existing data frame, summarize spits out a totally new data frame 

surveys %>%
  filter(is.na(sex)) %>% 
  View #way to look at all the NAs in the data frame 

surveys %>%  #tells us where the NAs are in species 
  group_by(species) %>% 
  filter(is.na(sex)) %>% 
  tally()

#you can use group_by with multiple columns
surveys %>% 
    group_by(sex,species_id) %>% 
    summarize(mean_weight = mean(weight)) %>% 
    View
#got NaN - not a number, can't calculate

surveys %>% 
  filter(!is.na(weight)) %>% 
    group_by(sex,species_id) %>% 
    summarize(mean_weight = mean(weight)) %>% 
    View

#summarize multiple thing
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex,species_id) %>% 
  summarize(mean_weight = mean(weight),min_weight=min(weight)) %>% 
  View

#tally function
tally_df<- 
  surveys %>% 
  group_by(sex,species_id) %>% 
  tally() %>% 
  View
# tally - create a tibble, just count
# tally () same as group_by (sth) %>% summarise = (new_column= n())

#gathering and spreading

#each variable have its own colomn
#each row 
#each type 

#spreading: long format -> wide format

#spread (data,key column var, value var (populate))

surveys_gw <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus,plot_id) %>%
  summarise (mean_weight = mean(weight))

surveys_spread <- surveys_gw %>%
  spread (key=genus, value= mean_weight)
# you can look it up.... it's normal to be confusing


surveys_gw %>% 
  spread(genus,mean_weight,fill = 0)
  #fill = 0 , #change NA -> 0 ... not remove

#gatherings
  #do a lot less...
# key = which to create from the column name, value = mean weight, - name of the column to use.dropout

surveys_gather <- surveys_spread %>% 
  gather(key=genus, value = mean_weight,-plot_id)
  #NA is backkkk, 0 didn't hold

#assignment with munozbird