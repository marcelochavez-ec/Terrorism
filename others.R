
# Create own color palette
myColors <- c("Unknown/Others" = "#999999",
              "Lone Wolf" = "#663000",
              "Islamic State" = "#E61A33",
              "Boko Haram" = "#664CFF",
              "Taliban" = "#FF8000",
              "Al-Shabaab" = "#FFFF33",
              "PKK" = "#33FF00",
              "Al-Qaeda" = "#1AB2FF")

# Plot --------------------------------------------------------------------

map.world <- map_data("world")

# get rid of Antarctica
map.world <- map.world[map.world$region != "Antarctica",]

library(ggplot2)
library(viridis) # scale_fill_viridis
library(RColorBrewer)

# https://timogrossenbacher.ch/2016/12/beautiful-thematic-maps-with-ggplot2-only/#reproducibility
theme_map <- function(...) {
  theme_minimal() +
    theme(
      #text = element_text(family = "Courier New", color = "#2B2B2B"),
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      #panel.grid.minor = element_line(color = "#ebebe5", size = 0.2),
      #panel.grid.major = element_line(color = "#ebebe5", size = 0.2),
      panel.grid.minor = element_blank(),
      panel.grid.major = element_blank(),
      plot.background = element_rect(fill = "#f5f5f2", color = NA), 
      panel.background = element_rect(fill = "#f5f5f2", color = NA), 
      legend.background = element_rect(fill = "#f5f5f2", color = NA),
      panel.border = element_blank(),
      ...
    )
}

# https://stackoverflow.com/questions/32649426/ggplot-combining-size-and-color-in-legend
# color: http://sharpsightlabs.com/blog/human-capital-map/
# combine legend through identical name + limits

ggplot() +
  geom_polygon(data = map.world, aes(x = long, y = lat, group = group), fill = "#2B2B2B", linetype = "blank") +
  geom_point(data = df, aes(x = lon, y = lat, size = Dead, color = Perpetrator), alpha = .5) +
  geom_point(data = df, aes(x = lon, y = lat, size = Dead, color = Perpetrator), shape = 1) +
  #scale_color_viridis(name = "test", option = "plasma") +
  scale_colour_manual(values = myColors) +
  #scale_color_gradientn(colours = rev(heat.colors(8))) +
  #scale_color_gradient2(name = "Fatalities", limits = c(0,500), breaks = c(0,50,100,500), low = "green", mid = "yellow", high = "red", midpoint = 50) +
  scale_size_continuous(name = "Fatalities", limits = c(0,500), range = c(.5, 5), breaks = c(0,50,100,500)) +
  #guides(color = guide_legend(reverse = TRUE, override.aes = list(alpha = 1, size = 5) )) +
  guides(color = guide_legend(override.aes = list(size = 3),
                              title.position = 'top',
                              title.hjust = 0.0
                              ),
         size = guide_legend(title.position = 'top',
                             title.hjust = 0.1)) +
  #coord_map(xlim = c(-180,180)) +
  coord_map("rectangular", lat0 = 0, ylim = c(-55, 90), xlim = c(-180,180)) +
  labs(title = "Terrorist incidents between 2015 and 2017"
       ,subtitle = "Terrorism related to drug wars and cartel violence is not included"
       ,caption = "Map CC-BY-SA; Author: Dominik Koch (dominikkoch.github.io)\nData: https://en.wikipedia.org/w/index.php?title=List_of_terrorist_incidents") +
  theme_map() +
  theme(text = element_text(colour = "#444444", family = "Gill Sans")
        # # Change background colour
        # ,panel.background = element_rect(fill = alpha('white', 0.0))
        # ,plot.background = element_rect(fill = alpha('white', 0.0))
        # ,legend.background = element_rect(fill = alpha('white', 0.0))
        # # Elimnate grid
        # ,panel.grid = element_blank()
        # # Eliminate axis
        # ,axis.title = element_blank()
        # ,axis.ticks = element_blank()
        # ,axis.text = element_blank()
        # Margin
        # ,plot.margin = unit(c(.5,.5,.2,.5), "cm")
        # ,panel.spacing = unit(c(-.1,0.2,.2,0.2), "cm")
        #,panel.border = element_blank()
        # Adjust titles
        ,plot.title = element_text(hjust = 0.5, color = "#2B2B2B")
        ,plot.subtitle = element_text(hjust = 0.5,  color = "#2B2B2B")
        ,plot.caption = element_text(size = 6, 
                                    hjust = 1, 
                                    # margin = margin(t = 0.2, 
                                    #                b = 0, 
                                    #                unit = "cm"), 
                                    color = "#939184")
        # Adjust legend
        #,legend.key = element_rect(fill = alpha('white', 0.0))
        ,legend.text = element_text(size = 7, hjust = 0, color = "#2B2B2B")
        ,legend.position = "bottom" #c(.1,.175)
        ,legend.title = element_text(size = 8)
  ) 

# todo
# colour points
# try other data for maps # https://github.com/tidyverse/ggplot2/issues/1104

# colors from dichromat
# colorschemes$Categorical.12
# [1] "#FFBF80" "#FF8000" "#FFFF99" "#FFFF33" "#B2FF8C" "#33FF00" "#A6EDFF" "#1AB2FF"
# [9] "#CCBFFF" "#664CFF" "#FF99BF" "#E61A33"

# Dark themed
# ggplot() +
# geom_polygon(data = map.world, aes(x = long, y = lat, group = group), fill = "#191A1A", linetype = "blank") +
#   geom_point(data = df, aes(x = lon, y = lat, size = Dead, color = Dead), alpha = .5) +
#   geom_point(data = df, aes(x = lon, y = lat, size = Dead, color = Dead), shape = 1) +
#   scale_color_gradient2(name = "Fatalities", limits = c(0,500), breaks = c(0,50,100,500), low = "green", mid = "yellow", high = "red", midpoint = 50) +
#   scale_size_continuous(name = "Fatalities", limits = c(0,500), range = c(.9, 11), breaks = c(0,50,100,500)) +
#   #guides(color = guide_legend(reverse = TRUE, override.aes = list(alpha = 1, size = 5) )) +
#   guides(color = guide_legend(), size = guide_legend()) +
#   labs(title = "Possible cities for new Amazon Headquarters"
#        ,subtitle = "Based on population & percent of people with college degrees"
#        ,caption= "data source") +
#   theme(text = element_text(colour = "#444444", family = "Gill Sans")
#         # Change background colour
#         ,panel.background = element_rect(fill = "#343332")
#         ,plot.background = element_rect(fill = "#343332")
#         ,legend.background = element_rect(fill = "#343332")
#         # Elimnate grid
#         ,panel.grid = element_blank()
#         # Eliminate axis
#         ,axis.title = element_blank()
#         ,axis.ticks = element_blank()
#         ,axis.text = element_blank()
#         # Adjust titles
#         ,plot.title = element_text(size = 28)
#         ,plot.subtitle = element_text(size = 12)
#         # Adjust legend
#         ,legend.key = element_rect(fill = "#343332", colour = "#343332")
#         ,legend.position = "bottom"
#   ) 
  

library(leaflet)
data(quakes)

# # Plot markers on map
# leaflet(data = quakes[1:20,]) %>% 
#   addTiles() %>% 
#   #addMarkers(clusterOptions = markerClusterOptions())
#   addMarkers(~long, ~lat, popup = ~as.character(depth), label = ~as.character(mag))

# # Automatic clusters on map
# leaflet(data = df) %>% 
#   addTiles() %>% 
#   addMarkers(~lon, ~lat, clusterOptions = markerClusterOptions())

# # Dummy Colours
# df$color <- as.factor(sample(1:5, size = nrow(df), replace = TRUE))
# factpal <- colorFactor(topo.colors(5), domain = df$color)



# leaflet(data = df) %>% 
#   addTiles() %>% 
#   addProviderTiles(providers$CartoDB.DarkMatter) %>% 
#   addCircles(lng = ~lon, lat = ~lat, radius = ~Dead*10000, weight = 5,
#              color = ~factpal(color),
#              fillColor = ~factpal(color),
#              stroke = TRUE,
#              opacity = 0.8,
#              fillOpacity = 0.4)

df$color <- as.numeric(as.character(df$Year))
factpal <- colorFactor(topo.colors(3), domain = df$color)

df$color <- df$Perpetrator
factpal <- colorFactor(rev(c('#999999','#663000','#E61A33','#664CFF','#FF8000','#FFFF33','#33FF00','#1AB2FF')), domain = df$color)

leaflet(data = df) %>% 
  addTiles() %>% 
  addProviderTiles(providers$CartoDB.DarkMatterNoLabels) %>% 
  addCircleMarkers(lng = ~lon, lat = ~lat, radius = ~sqrt(Dead) * 1.0 + 3, weight = 2,
                   color = ~factpal(color),
                   opacity = 0.3,
                   fillColor = ~factpal(color),
                   fillOpacity = 0.2,
                   popup = ~Details,
                   label = ~Location)


# https://api.mapbox.com/styles/v1/mapbox/dark-v9.html?title=true&access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NDg1bDA1cjYzM280NHJ5NzlvNDMifQ.d6e-nNyBDtmQCVwVNivz7A#2/0/0


# https://rpubs.com/walkerke/rstudio-mapbox
ugly_map <- "https://api.mapbox.com/styles/v1/mapbox/dark-v9/tiles/{z}/{x}/{y}?access_token=pk.eyJ1Ijoia3dhbGtlcnRjdSIsImEiOiJjaW9jenN1OGwwNGZsdjRrcWZnazh2OXVxIn0.QJrmnV9lJzdXHkH95ERdjw"

mb_attribution <- "© <a href='https://www.mapbox.com/map-feedback/'>Mapbox</a> © <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a>"

leaflet(df) %>% 
  addCircleMarkers(lng = ~lon, lat = ~lat, radius = ~sqrt(Dead) * 1.5 + 3, weight = 2,
                   color = ~factpal(color),
                   opacity = 0.3,
                   fillColor = ~factpal(color),
                   fillOpacity = 0.2,
                   popup = ~Details,
                   label = ~Location) %>% 
  addTiles(urlTemplate = ugly_map, attribution = mb_attribution)


# Hosting tokens
# https://github.com/STAT545-UBC/Discussion/issues/301
# https://www.mapbox.com
# https://api.mapbox.com/styles/v1/mapbox/dark-v9.html?title=true&access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NDg1bDA1cjYzM280NHJ5NzlvNDMifQ.d6e-nNyBDtmQCVwVNivz7A#0.86/0/0