dev.off()

library(tidyverse)
gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

#1A.Modify the following code to make a figure that shows how life expectancy has changed over time:

#ggplot(gapminder, aes(y = gdpPercap, x = lifeExp)) +geom_point()

gapminder %>% 
  ggplot(aes(x=year,y=lifeExp,group=year))+
  geom_jitter(alpha=0.5, color = "salmon")+
  geom_boxplot(alpha = 0.2, color = "brown")
 
#1B.Look at the following code. What do you think the scale_x_log10() line is doing? What do you think the geom_smooth() line is doing?

#Hint: There’s no cost to tinkering! Try some code out and see what happens with or without particular elements.

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()
#transform gdp per capita with log 10 for more spread visualization
#geom_smooth() make the data smoother and fitter to the linear model line


#1C. (Challenge!)
#Modify the above code to size the points in proportion to the population of the county. Hint: Are you translating data to a visual feature of the plot?
#Save this code in your scripts folder and name is w6_assignment_ABC.R with your initials.

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp, alpha=0.3,size =pop,show.legend = F)) +
  geom_point(aes(color = continent)) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed',show.legend = F)+
  theme_bw()
