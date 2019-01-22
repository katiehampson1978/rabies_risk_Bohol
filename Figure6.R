## Manuscript: On the path to rabies elimination: the need for risk assessments to improve administration of post-exposure prophylaxis
## Name: Kristyna Rysava
## Date: 12/06/18
## Code: Figure 6 

rm(list=ls())

### Libraries ###
library(rgdal)
library(maptools)
library(RColorBrewer)

### Data ###
confirmed <- read.csv("data/Confirmed_cases.csv")
probable <- read.csv("data/Probable_cases.csv")

### Shapefiles ###
muni <- readOGR("data/Bohol_municipalities/Bohol_municipalities.shp",  layer="Bohol_municipalities")
bar <- readOGR("data/Bohol_barangays/Bohol_barangays.shp",  layer="Bohol_barangays")

### Create colours for choropleth map of dog vaccination coverage ###
quantile(as.numeric(bar@data$vacc_13))
breaks <- c(0,10,20,50,70,80,100)
colours <- brewer.pal((length(breaks)-1), "Blues")

### Create colours for case points ###
red.IC <- adjustcolor("red", alpha.f = 0.5)
darkred.IC <- adjustcolor("darkred", alpha.f = 0.5)

### Draw vaccination coverage map ###
pdf("Rysava_etal2018_Figure6.pdf", width=5.5, height=4)
par(mar=c(0,0,0,0))
plot(bar, col="grey90", border="grey50")
plot(bar, add=T, border=NA, col=colours[findInterval(as.vector(as.character(bar@data$vacc_13)),
                                                          breaks,all.inside=T)])
plot(muni,add=T,border="grey60", lwd=.3) # municipalities

# add cases
plot(SpatialPoints(data.frame(confirmed[,7:8]), proj4string = CRS("+proj=utm +zone=51")), 
     add=T, cex=1.5, pch=19, col=red.IC)
plot(SpatialPoints(data.frame(probable[,7:8]), proj4string = CRS("+proj=utm +zone=51")), 
     add=T, cex=1.5, pch=17, col=darkred.IC)

# add legend to map
legend(565270, 1134140,
       legend=c(leglabs(breaks, under="<",over=">"),"Municipality boundaries",
                "Rabies positive cases","Rabies probable cases"),
       lty=c(rep(0,length(breaks)-1),1,0,0),
       col = c(rep("black",length(breaks)-1),"grey60","red", "darkred"),
       pch=c(rep(22,length(breaks)-1),NA,19,17), 
       pt.bg=c(colours,NA), pt.cex=0.7, lwd=c(rep(.2,7),.9),
       title=c("Vaccination coverage (%)"), text.width=.5,
       cex=0.5, bty="n")

# add scale
polygon(x=c(661102, 671102, 671102, 661102), y=c(1067224, 1067224, 1067124, 1067124), col="black") # add scale
text(666102, 1065824, "10 km", cex=0.5)

dev.off()
