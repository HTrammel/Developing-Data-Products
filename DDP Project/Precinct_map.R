
library(ggmap)
library(RgoogleMaps)
require(rgdal)
require(ggplot2)

Precincts <- readOGR("./Police_Precincts","nypp")
Precincts <- spTransform(Precincts, CRS("+proj=longlat +datum=WGS84"))
Precincts <- fortify(Precincts)
CenterOfMap <- geocode("New York, NY")
New_York <- get_map(c(lon=CenterOfMap$lon,
                        lat=CenterOfMap$lat),
                        zoom = "auto",
                        scale="auto",
                    maptype = "toner", source = "stamen")
New_YorkMap <- ggmap(New_York)

New_YorkMap <- New_YorkMap +
               geom_polygon(aes(x=long, y=lat, group=group),
                            fill='grey',
                            size=.3,
                            color='red',
                            data=Precincts,
                            alpha=0)
print(New_YorkMap)
