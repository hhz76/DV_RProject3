require("tidyr")
require("dplyr")
require("jsonlite")
require("grid")

myplot <- function(df, x) {
  names(df) <- c("x", "n")
  ggplot(df, aes(x=x, y=n)) + geom_point()
}

categoricals <- eval(parse(text=substring(getURL(URLencode('http://129.152.144.84:5001/rest/native/?query="select year,zip_code, predominant_age_group, count, city from age_grouping"'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_hhz76', PASS='orcl_hhz76', MODE='native_mode', MODEL='model', returnFor = 'R', returnDimensions = 'True'), verbose = TRUE), 1, 2^31-1)))

ddf <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select year,zip_code, predominant_age_group, count, city from age_grouping"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_hhz76',PASS='orcl_hhz76',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)));

l <- list()
for (i in names(ddf)) { 
  if (i %in% categoricals[[1]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\", count(*) n from age_grouping group by \\\""i"\\\" "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_hhz76',PASS='orcl_hhz76',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i = i),verbose = TRUE)))
    p <- myplot(r,i)
    print(p) 
    l[[i]] <- p
  }
}

png("../03 Visualizations/categorical.png", width = 25, height = 10, units = "in", res = 72)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 5)))   

print(l[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:3))
print(l[[2]], vp = viewport(layout.pos.row = 1, layout.pos.col = 4:5))

dev.off()