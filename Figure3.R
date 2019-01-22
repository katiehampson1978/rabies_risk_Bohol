## Manuscript: On the path to rabies elimination: the need for risk assessments to improve administration of post-exposure prophylaxis
## Name: Kristyna Rysava
## Date: 12/06/18
## Code: Figure 3a,b

rm(list=ls())

### Data ###
yrdat <- read.csv("data/BiteIncidence_2007-2013.csv"); head(yrdat)

### Draw timeseries plot ###
pdf("Rysava_etal2018_Figure3.pdf", width=10, height=4)
par(mfrow=c(1,2), mar=c(5,4.5,2,1.5))
plot(1:7, yrdat$Incidence, cex.axis=.7, type="o", col="grey20", pch=20, ylim=c(0,450),
     xlab="Time (years)", ylab="Bite incidence/100,000", cex.lab=.7, xaxt="n", bty="n", lwd=1)
axis(1,at=1:7,lab=paste(2007:2013),tck=-0.04, cex.axis=.7) 

plot(1:7, yrdat$Hum_death, cex.axis=.7, col="grey20",xaxt="n", type="o", pch=20,
     cex.lab=.7, bty="n", xlab="Time (years)", ylab="Number of human deaths")
axis(1,at=1:7,lab=paste(2007:2013),tck=-0.04, cex.axis=.7) 
dev.off()



  
  
