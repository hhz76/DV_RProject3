require("tidyr")
require("dplyr")
require("jsonlite")
require("ggplot2")
require("reshape2")

#Visualization 1 is in data_wrangling.R

#Visualization 2
ggplot(age_vs_weight, aes(x=PREDOMINANT_AGE_GROUP, y =BIRTHWEIGHT, stat = "bin")) + geom_dotplot() + ggtitle("AGE vs. WEIGHT") + theme(plot.title = element_text(size=25, face = "italic", vjust = 1))

#Visualization 3
ggplot(race_weights, aes(x=PREDOMINANT_RACE,fill=PREDOMINANT_RACE))+geom_histogram()+facet_grid(BIRTHWEIGHT~.) + ggtitle("Dist. of Birth Weights by Predominant Race") + theme(axis.text.x=element_text(angle=50,size=10,face="bold",vjust=0.5)) + theme(plot.title = element_text(size=20,face="bold",vjust=1,hjust = 0,colour="chocolate")) + theme(axis.text.y=element_text(size=10,face="bold",vjust=2))+theme(strip.text.y=element_text(size=10,face="bold",colour="red"))