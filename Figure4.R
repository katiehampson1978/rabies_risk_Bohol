## Manuscript: On the path to rabies elimination: the need for risk assessments to improve administration of post-exposure prophylaxis
## Name: Kristyna Rysava
## Date: 12/06/18
## Code: Figure 4a,b

rm(list=ls())

### Libraries ###
library(rgdal)
library(maptools)
library(RColorBrewer)

### Data ###
exposures <- read.csv("data/HumanExposures_2013.csv")

### Shapefiles ###
muni <- readOGR("data/Bohol_municipalities/Bohol_municipalities.shp",  layer="Bohol_municipalities")
bar <- readOGR("data/Bohol_barangays/Bohol_barangays.shp",  layer="Bohol_barangays")

### Create colours for choropleth map of bite incidience ###
quantile(as.numeric(as.character(bar$inc2013)))
breaks <- c(0,100,200,500,1000,2000,4000,max(as.numeric(as.character(bar$inc2013))))
colours <- brewer.pal((length(breaks)-1), "Reds") 
colours <- c("white", colours[1:6])

### Draw bite incidence map ###
pdf("Rysava_etal2018_Figure4a.pdf", width=5.5, height=4)
par(mar=c(0,0,0,0))
plot(bar, col="grey90", border="grey50")
plot(bar, add=T, border=NA, col=colours[findInterval(as.vector(as.character(bar$inc2013)),
                                                          breaks,all.inside=T)])
plot(muni,add=T,border="grey60", lwd=.3) # municipalities

# add legend to map
legend(565270, 1134140,
       legend=c(leglabs(breaks, under="<",over=">"),"Municipality boundaries"),
       lty=c(rep(0,length(breaks)-1),1),
       col = c(rep("black",length(breaks)-1),"grey60"),
       pch=c(rep(22,length(breaks)-1), NA),
       pt.bg=c(colours,NA), pt.cex=0.7, lwd=c(rep(.2,7),.9),
       title=c("Bite incidence/100,000"), text.width=.5,
       cex=0.5, bty="n")

# add scale
polygon(x=c(661102, 671102, 671102, 661102), y=c(1067224, 1067224, 1067124, 1067124), col="black") # add scale
text(666102, 1065824, "10 km", cex=0.5)

dev.off()

### Draw bite incidence timeseries ###
pdf("Rysava_etal2018_Figure4b.pdf", width=6.5, height=4)
par(mar=c(5,4,3,4.2))
plot(1:12, exposures$exps, cex.axis=.7, type="o", col="grey20", ylim=c(0,500),
     xlab="Time (months)", 
     ylab="Number of dog-bite patients (line)", 
     cex.lab=.7, xaxt="n", bty="n", lwd=1)
axis(1,at=seq(1,12,2), lab=c("Jan", "Mar", "May", "Jul", "Sep", "Nov"), tck=-0.04, cex.axis=.7)
axis(1,at=1:12,lab=rep("",12),tck=-0.01)

# add bites
rect(3.3,0,3.5,30,border="gray40",col="gray40") # 3 cases
rect(4.3,0,4.5,170,border="gray40",col="gray40") # 17 cases
rect(6.3,0,6.5,220,border="gray40",col="gray40") # 22 cases
rect(7.3,0,7.5,10,border="gray40",col="gray40") # 1 cases
rect(8.3,0,8.5,10,border="gray40",col="gray40") # 1 cases

# add meat consumption
rect(3.6,0,3.8,270,border="gray80",col="gray80") # 27 cases
rect(6.6,0,6.8,50,border="gray80",col="gray80") # 5 cases

par(new=TRUE)
plot(1:12, 1:12, ylim=c(0,50), yaxt="n", xaxt="n", pch=16, type="n",bty="n", xlab="", ylab="")
axis(4, at=seq(0,50,10),lab=seq(0,50,10), cex.axis=.7)
mtext("Number of patients exposed to a rabies confirmed/probable dog (bars)", side = 4, line = 3, cex = .7)

dev.off()



