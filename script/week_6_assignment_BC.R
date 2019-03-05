library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv")

#1A - modify code to show change in life expectancy over time
ggplot(gapminder, aes(x = year, y = lifeExp)) + #change gdpPercap to year
  geom_point()

#1B - tinkering with geom_smooth and scale_x_log10
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() + 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') + 
  theme_bw()

#scale_x_log10 is transforming the x axis of gdpPercap to a log scale with base 10, allowing us to see a     better trend in the data along the x axis
#geom_smooth is adding a trend line and helping to show the trend of the data in the presence of overplotting

#1C - Challenge - Modify the above code to size the points in proportion to the population of the country
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop, alpha = 1)) + 
  scale_x_log10() + 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') + 
  theme_bw()
#I added "size = pop" in the geom_point function to make the size of points correspond to the population of their respective country 
#I also added "alpha = 1" to geom_point to give the overlapping points some transparency

