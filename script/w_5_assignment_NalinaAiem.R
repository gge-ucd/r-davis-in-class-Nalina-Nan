
library(tidyverse)

surveys<-read_csv("data/portal_data_joined.csv")

#subset to keep all the rows where weight is between 30 and 60, then print the first few (maybe… 6?) rows of the resulting tibble

filter1<-surveys %>% 
  filter(weight >30  & weight < 60) %>%
  head(6)

#Make a tibble that shows the max (hint hint) weight for each species+sex combination, and name it biggest_critters. Use the arrange function to look at the biggest and smallest critters in the tibble (use ?, tab-complete, or Google if you need help with arrange).
#don't know how to use arrange
biggest_critters <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species,sex) %>% 
  summarise (max_weight = max(weight))


#Try to figure out where the NA weights are concentrated in the data- is there a particular species, taxa, plot, or whatever, where there are lots of NA values? There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. Maybe use tally and arrange here.
  
surveys %>%  #tells us where the NAs 
    group_by(species,sex,taxa,plot_type) %>% 
    filter(is.na(weight)) %>% 
    tally() %>% 
    arrange(desc(n))
#harrisi has a lot of NA

#Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight. The resulting tibble should have 32,283 rows.

surveys_avg_weight<-
  surveys %>%  #tells us where the NAs are in species 
  filter(!is.na(weight)) %>% 
  group_by(species,sex) %>% 
  mutate(mean_weight=mean(weight)) %>% 
  select(species,sex,weight,mean_weight)

#Challenge: Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination (recall the new column we made for this tibble).

surveys_avg_weight$above_average<-surveys_avg_weight$weight>surveys_avg_weight$mean_weight

#Extra Challenge: Figure out what the scale function does, and add a column to surveys that has the scaled weight, by species. Then sort by this column and look at the relative biggest and smallest individuals. Do any of them stand out as particularly big or small?

?scale
surveys_final<-
  surveys_avg_weight %>% 
  group_by(species) %>% 
  mutate(scale=scale(weight)) %>% 
  arrange(desc(scale))
  
#penicillatus F is particularly big