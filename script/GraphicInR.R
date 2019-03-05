library(datasauRus)
library(ggplot2)

str(datasaurus_dozen_wide, give.attr = FALSE)
str(datasaurus_dozen, give.attr = FALSE)

View(datasaurus_dozen_wide)
names(datasaurus_dozen_wide)

ggplot(datasaurus_dozen_wide, 
       aes(dino_x, dino_y)) +
  geom_point()

View(datasaurus_dozen)
ggplot(datasaurus_dozen,
       aes(x,y,col=dataset))+
  geom_point()+
  facet_wrap(~dataset)
?geom_point

counts_df = readRDS(paste0(data_dir, 'paper_counts.Rds'))
getwd()

data_dir='data/'

ggplot(counts_df, aes(subject_area)) + 
  geom_point(aes(y = full, color = 'full'), size = 3) +
  geom_point(aes(y = sample, color = 'Sample'), size = 3) +
  geom_segment(aes(x = subject_area, xend = subject_area, 
                   y = full, yend = sample))+
  ylab('share of dataset')+
  coord_flip()+
  theme_minimal() +
  theme(legend.position = c(.8,.2))+
  xlab('ASJC subject area') +
  scale_y_continuous(labels = scales::percent_format(), 
                     name = 'Papers in dataset') +
  scale_color_brewer(palette = 'Set1', 
                     name = 'Dataset') +
  ggtitle('Sampling improves balance across subject areas',
          subtitle = Sys.time()) +
  annotate(geom = 'label', x = 'HEAL', y = .12, label = Sys.time())

temp_df = readRDS(paste0(data_dir, 'temp.Rds'))
str(temp_df)

thing = ggplot(temp_df, aes(temp_max, temp_delta)) +
  #geom_point()+
  #geom_count()+
  #geom_bin2d()+
  #geom_hex(aes(color=..count..))+
  #geom_density2d()+
  #stat_density2d(contour = F, geom = 'raster', aes(fill = ..density..), show.legend = F) +
  stat_density2d(geom = 'polygon', aes(fill = ..level..), show.legend = FALSE) +
  facet_wrap(~name)+
  scale_color_viridis_c(option='A')+
  scale_fill_viridis_c(option='A')

plots_dir='figures/'

ggsave(thing,paste0(plots_dir, 'plot_2.png'), height = 7, width = 7)
#paste0 = doesn't leave a space, concatenate

dev.off()
