##import libraries 
library(data.table)
library(ggplot2)
library(dplyr)
library(gganimate)
library(devtools)
library(animation)

###################################
##Import dataset

##fread import 
life_data_sep_avg <- fread("C:/Users/Owner/Documents/haqseq2018/life_data_sep_avg.csv", sep = ",")

### Number of survivors at age x 

##Rplot 
# convert data types 
life_data_sep_avg[, Age_group := as.integer(Age_group)]
life_data_sep_avg[, YEAR := as.integer(YEAR)]

##prepare data for plot 
survivordata <- life_data_sep_avg[Element == "Number of survivors at age x (lx)" & Sex %in% c("M", "F") & YEAR %in% seq(1980, 2016, 4)]
survivordata
colnames(survivordata)

##generate ggplot & gganimate 
survivorggplot <- ggplot(survivordata, aes(Age_group, AVG_VALUE, color = Sex)) + 
  geom_point(alpha = 0.6, size = 2, show.legend = FALSE) + 
  facet_wrap(~ GEO) +
  scale_x_continuous(breaks = c(0, seq(20,120,20)), limits = c(0, 120)) + 
  scale_y_continuous(breaks = c(0, seq(10000, 100000, 10000))) + 
  scale_colour_discrete() +
  # gganimate values 
  labs(titles = 'Year: {frame_time}', x = 'Age', y = 'Number of Survivors') + 
  transition_time(YEAR)+
  ease_aes('linear')

##view survivor plot 
survivorggplot 
####################################
gganimate::anim_save(survivoranimatedplot, "C:/Users/Owners/Documents/haqseq2018/")

gganimate(gplot, ani.width= 1000, ani.height=1000, "test.gif")
gganimate(survivorggplot, ani.width = 1000, ani.height=1000, "survivalggplot_all.gif")
animation::ani.options(ani.width= 1000, ani.height=1000, ani.res = 1000)
anim_save("gganimsurvivorplot.gif", animation = last_animation(), path = '~')
anim_sav

save_