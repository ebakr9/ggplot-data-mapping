library(ggplot2)
library(tidyverse)
library(countrycode)
library(leaflet)
library("readxl")
library(gganimate)
library(ggiraph)
library(plotly)
df <- read_excel("C:/Users/Erdem/Documents/Shiny/democ_data.xls",range = "A1:V17575")
mapdata = map_data("world")
df = rename(df, "region"=country)

whichyear = 1900
df.2020 = df %>% filter(df$year==whichyear, df$polity >-11)
mapdata = left_join(mapdata,df.2020,by="region")
years = c(1800:2018)
map1 = ggplot(mapdata,aes(x=long, y=lat, group=group)) + geom_polygon(aes(fill = polity), color = "grey50")

map2 = map1+ scale_fill_gradient(name= "Democracy Index", low = "red", high = "yellow", na.value = "grey50")+
  theme(axis.title = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y.left = element_blank())+ggtitle(whichyear)

ggplotly(map2)


##Year? alamuyor muhtemelen - map2.animation = map2 + transition_time(df$year)
