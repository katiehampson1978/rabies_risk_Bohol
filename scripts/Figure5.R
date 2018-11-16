## Manuscript: On the path to rabies elimination: the need for risk assessments to improve administration of post-exposure prophylaxis
## Name: Kristyna Rysava
## Date: 12/06/18
## Code: Figure 5a,b,c

rm(list=ls())

### Data ###
costs <- read.csv("data/Scenarios_costs.csv")
WHOcat <- read.csv("data/WHO_categories.csv")
animals <- read.csv("data/Animal_status.csv")

### Draw WHO category barcharts ###
sum.cat <- table(WHOcat$category); sum.cat
my.red <- colorRampPalette(c("white", "red"))(8) 
my.red <- my.red[c(2,5,8)]

pdf("Rysava_etal2018_Figure5a.pdf", width=6, height=4)
par(mar=c(4,5,3,2))
mids <- barplot(sum.cat, ylab = "Number of exposures per WHO category",
                ylim=c(0,3000), col=c("grey80", my.red), border=c("grey80", my.red), xaxt="n")
legend(0,3000,legend=rownames(sum.cat),border=c("grey80", my.red), fill=c("grey80",my.red),cex=.7,bty="n")
dev.off()

### Draw animal status barcharts ###
sum.cases <- table(animals$status, animals$month); sum.cases
names <- c("Healthy","Not traceable","Killed","Died","Sick")
sum.cases <- sum.cases[names,]
colnames(sum.cases) <- c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
sum.cases

my.red <- colorRampPalette(c("white", "red"))(8) 
my.blue <- brewer.pal(7, "Blues"); my.blue <- my.blue[2] 
my.red <- my.red[c(3,4,6,8)]

pdf("Rysava_etal2018_Figure5b.pdf", width=6, height=4)
par(mar=c(4.2,5,3,2))
mids <- barplot(sum.cases, beside=F,xlab = "Time (months)",ylab = "Number of investigated dogs",
                ylim=c(0,600),col=c(my.blue, my.red), border=c(my.blue, my.red))
legend(0,600,legend=rownames(sum.cases),fill=c(my.blue, my.red), border=c(my.blue, my.red),cex=.7,bty="n")
dev.off()

### Draw surveillance costs barcharts ###
my.blue <- brewer.pal(8, "Blues")
my.red <- colorRampPalette(c("white", "red"))(8)
my.col <- c(my.red[6], my.blue[6], my.blue[3])

pdf("Rysava_etal2018_Figure5c.pdf", height=4, width=6)
barplot(`colnames<-`(t(costs[-1]), c("Scenario 1", "Scenario 2", "Scenario 3")), beside=TRUE,
        ylab="Total costs (USD)", cex.lab=.8, ylim=c(0, 80000), axes=F,
        legend.text = TRUE, col = my.col, border=NA, cex.names=.8, cex.axis=.8,
        args.legend = list(x = "topright", cex=.7, border= my.col,  bty = "n", inset=c(0, -0.1)))
axis(2, at=seq(0,80000,10000),lab=seq(0,80000,10000), cex.axis=1)
dev.off()
