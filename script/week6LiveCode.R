library (tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")

#take all NAs out of the weight, hindfoot_length, and sex columns

surveys_complete <- surveys %>% 
  filter(!is.na(weight),!is.na(hindfoot_length),!is.na(sex))

#remove the species < 50 obsvervation

species_counts<-surveys_complete %>% 
  group_by(species_id) %>% 
  tally() %>% #create new column name "n"
  filter(n>=50)

#%in%
#match the list to show data of species that appear in species count (which we selected to have > 50)

surveys_complete<-surveys_complete %>% 
  filter(species_id %in% species_counts$species_id)

#Select to look at some species
species_keep <- c("DM","DO")

surveys_complete %>% 
  filter(surveys_complete$species_id %in% species_keep)

#writing your dataframe to .csv

write_csv(surveys_complete,path = "data_output/surveysComplete.csv")


# 4# and a lot of sth... create a section
#### ggplot =========== 

#ts tab - current date and time
# Tue Feb 12 14:31:20 2019 ------------------------------

#painting from the blank canvas
# adding on layer

#ggplot(data=DATA,mapping=aes(HowToMapInCanvas))+
#geom_function(putSthOnIt)

ggplot(surveys_complete) 

#define a mapping

ggplot(data = surveys_complete, mapping = aes (x=weight,y=hindfoot_length)) + #define x and y axis # end with +
  geom_point()

#saving a plot object 
survey_plot <- ggplot(data = surveys_complete, mapping = aes (x=weight,y=hindfoot_length))

#save the same baseline canvas and adapt 
survey_plot + 
  geom_point()

#anything in ggplot func, will be seen in geom_ you add

# can modify each geom on its own 

#challenge

#install.packages("hexbin")
library(hexbin)
survey_plot + 
  geom_hex()
#avoid overplotting

#we're going to build points from ground up
        
#modifying whole geom appearances
surveys_complete %>% 
  ggplot (aes(x=weight,y=hindfoot_length)) +
  geom_point(alpha=0.1,col="tomato") #alpha = transparency

#using data in geom

surveys_complete %>% 
  ggplot(aes(x=weight,y=hindfoot_length))+
  geom_point (alpha=0.1, aes (col=species_id)) #add color locally

#putting color as a global aesthetic, every function after that still look at color
surveys_complete %>% 
  ggplot(aes(x=weight,y=hindfoot_length, col=species_id))+
  geom_point (alpha=0.1)

#using a little jitter
surveys_complete %>% 
  ggplot(aes(x=weight,y=hindfoot_length, col=species_id))+
  geom_jitter (alpha=0.1) #jitter seperate them out a bit for a better view

#moving on to boxplot
surveys_complete %>% 
  ggplot(aes(x=species_id,y=weight))+
  geom_boxplot()

#adding points to boxplot
surveys_complete %>% 
  ggplot(aes(x=species_id,y=weight))+
  geom_boxplot() + 
  geom_jitter(alpha=0.3, color = "salmon") #use jitter because point will too dense in the line

# change the layer to show boxplot
surveys_complete %>% 
  ggplot(aes(x=species_id,y=weight))+
  geom_jitter(alpha=0.3, color = "salmon")+
  geom_boxplot(alpha = 0.2) #make fill more transparent
#color #fill = inside

#plotting time series
yearly_count<-surveys_complete %>% 
    count(year,species_id) #same as group by specie id&year, tally
  
yearly_count %>% 
  ggplot(aes(x=year,y=n,group=species_id,color=species_id))+
  geom_line()

#facetting
yearly_count %>% 
  ggplot (aes(x=year,y=n,col=species_id))+
  geom_line()+
  facet_wrap(~species_id) #subplot(facet) by ~

#including sex
yearly_sex_counts<-surveys_complete %>% 
  count(year,species_id,sex)

yearly_sex_counts %>% 
  ggplot(aes(x=year,y=n,color=sex))+
  geom_line()+
  facet_wrap(~species_id)+
  theme_linedraw()+ #a lot of THEME lol
  theme (panel.grid = element_blank())


#save any stage

ysx_plot <-yearly_sex_counts %>% 
  ggplot(aes(x=year,y=n,color=sex))+
  geom_line()+
  facet_wrap(~species_id)

ysx_plot<-
  theme_minimal()

#ggthemes::theme_tufle

# alittle more facetting
yearly_sex_weight<-surveys_complete %>% 
  group_by(year,sex,species_id) %>% 
  summarise(avg_weight=mean(weight))

yearly_sex_weight %>% 
  ggplot(aes(x = year, y = avg_weight, color = species_id)) +
  geom_line() +
  facet_grid(sex~.) # . = nothing, want to divided by

# facet_grid uses rows ~ columns for facetting. the "." indicates nothing in this dimension

#adding label and stuff 
yearly_sex_counts %>% 
  ggplot(aes(x = year, y = n, color = sex)) +
  geom_line() +
  facet_wrap(~ species_id) +
  theme_bw() +
  theme(panel.grid = element_blank()) +
  labs(title="Observed species through time", x="Year of observation", y="Number of species")+
  theme(text = element_text(size = 16)) +
  theme(axis.text.x = element_text(color = "grey20", size = 12, angle = 90 , hjust = 0.5, vjust = 0.5))

ggsave("figures/my_test_facet_plot.jpeg",height = 8, width = 8) #recognize the type of file you lastly saved

#ggplot2Ref

#source ("")#run the whole script into my env.

#brcurrinder


