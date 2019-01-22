## Manuscript: On the path to rabies elimination: the need for risk assessments to improve administration of post-exposure prophylaxis
## Name: Kristyna Rysava
## Date: 12/06/18
## Code: Figure 1

rm(list=ls())

### Libraries ###
library(rgdal)
library(maptools)
library(RColorBrewer)

### Data ###
ABTC.location <- read.csv("data/Bohol_ABTC.csv")
ABC.location <- read.csv("data/Bohol_ABC.csv")

### Shapefiles ###
muni <- readOGR("data/Bohol_municipalities/Bohol_municipalities.shp",  layer="Bohol_municipalities")
bar <- readOGR("data/Bohol_barangays/Bohol_barangays.shp",  layer="Bohol_barangays")
phl <- readOGR("data/PHL_provinces/PHL_provinces.shp",  layer="PHL_provinces")
roads <- readOGR("data/Bohol_roads/Bohol_roads.shp",  layer="Bohol_roads")

### Create colours for choropleth map of human density ###
quantile(as.numeric(bar$hum_dns))
breaks <- c(0,20,100,300,500,1000,5000,max(as.numeric(bar$hum_dns)))
colours <- brewer.pal((length(breaks)-1), "Blues")

### Draw denisty map ###
pdf("figs/Rysava_etal2018_Figure1.pdf", width=7, height=4)
par(mar=c(0,0,0,2))
plot(bar, col="grey90", border="grey50")
plot(bar, add=T, border=NA, col=colours[findInterval(as.vector(as.character(bar$hum_dns)),
                                                          breaks,all.inside=T)])
plot(muni,add=T,border="grey60", lwd=.3) # municipality borders

plot(roads, add=T, col="grey20", lwd=.3) # roads
plot(roads[which(roads@data$type=="primary" | roads@data$type=="primary_link"),], add=T, col="grey20")
plot(roads[which(roads@data$type=="secondary"),], add=T, col="grey20", lwd=.8)
plot(roads[which(roads@data$type=="tertiary"),], add=T, col="grey20", lwd=.5)

# add clinic locations
plot(SpatialPoints(data.frame(ABTC.location[,2:3]), proj4string = CRS("+proj=utm +zone=51")),
     add=T, pch=17, cex=1.2, col="brown3")
plot(SpatialPoints(data.frame(ABC.location[,2:3]), proj4string = CRS("+proj=utm +zone=51")),
     add=T, pch=25, cex=1, col="brown", bg="brown")

# add legend to map
legend(565270, 1134140,
       legend=c(leglabs(breaks, under="<",over=">"),
                "Animal Bite Treatment Center","Animal Bite Clinic",
                "Municipality Boundary","Roads"),
       lty=c(rep(0,length(breaks)+1),1,1),
       col = c(rep("black",length(breaks)-1),"brown3", "brown", "grey60", "grey20"),
       pch=c(rep(22,length(breaks)-1),17,25,NA,NA),
       pt.bg=c(colours,"brown3","brown",NA,NA), pt.cex=0.7, lwd=c(rep(.2,8),.9),
       title=c("Human density"), text.width=.5,
       cex=0.5, bty="n")

# add scale
polygon(x=c(661102, 671102, 671102, 661102), y=c(1067224, 1067224, 1067124, 1067124), col="black")
text(666102, 1065824, "10 km", cex=0.5)

# add inset map of the Philippines
par(new=TRUE, mar=c(0,0,0,0),mfrow=c(1,1), plt=c(0.79, 0.99, 0.57, 0.93), cex=0.9)
plot(phl, col="gray80",border="gray80",bty="n")
plot(phl[which(phl@data$NAME_1=="Bohol"),], add=T, col="blue", border="blue")

dev.off()


