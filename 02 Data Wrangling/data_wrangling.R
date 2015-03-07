require("tidyr")
require("dplyr")
require("jsonlite")
require("ggplot2")
require("reshape2")

race_vs_age <- filter(race_vs_age, AGE != "UNK", AGE != "UKN", TOTAL != "null")
race_vs_age$TOTAL <- as.character(race_vs_age$TOTAL)
race_vs_age$TOTAL[race_vs_age$TOTAL == "<NA>"] <- "0"
race_vs_age$TOTAL <- as.numeric(race_vs_age$TOTAL)
race_vs_age %>% spread(AGE, TOTAL) %>% melt(id.var="PREDOMINANT_RACE") %>% ggplot(aes(x = PREDOMINANT_RACE, y = value, fill = variable)) + geom_bar(stat = "identity") + ggtitle("Number of Births by Race, Segmented by Age of Mother") + theme(axis.text.x=element_text(angle=50, size=10, vjust=0.5)) + theme(plot.title = element_text(size=13, face = "bold", hjust = 0.4, vjust = 2))

age_vs_weight <- age_grouping %>% filter(PREDOMINANT_AGE_GROUP != "UNK") %>% inner_join(b_weights, by = "LATITUDE", "LONGITUDE") %>% filter(BIRTHWEIGHT != "UNK")

age_vs_weight$LOCATION.y <- NULL
age_vs_weight$LOCATION.x <- NULL
age_vs_weight$ZIP_CODE.x <- NULL
age_vs_weight$ZIP_CODE.y <- NULL
age_vs_weight$STATE.y <- NULL
age_vs_weight$STATE.x <- NULL
age_vs_weight$CITY.x <- NULL
age_vs_weight$CITY.y <- NULL
age_vs_weight$LONGITUTE <- NULL
age_vs_weight$YEAR.x <- NULL
age_vs_weight$YEAR.y <- NULL
age_vs_weight$COUNT.y <- NULL
age_vs_weight$COUNT.x <- NULL
age_vs_weight$LONGITUDE <- NULL
age_vs_weight$LATITUDE <- NULL

race_weights <- race_grouping %>% filter(PREDOMINANT_RACE != "UNK", PREDOMINANT_RACE != "UKN") %>% full_join(b_weights,by = "ZIP_CODE","YEAR") %>% filter(BIRTHWEIGHT != "UNK") 

race_group <- race_weights %>% group_by(PREDOMINANT_RACE,BIRTHWEIGHT) %>% summarize(sum = sum(COUNT))