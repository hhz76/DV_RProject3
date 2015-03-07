require("tidyr")
require("dplyr")
require("jsonlite")
require("RCurl")

b_weights <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from birth_weights"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_hhz76', PASS='orcl_hhz76', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

head(b_weights)

b_race <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from birth_race"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_hhz76', PASS='orcl_hhz76', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

head(b_race)

b_age <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from births_by_age"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_hhz76', PASS='orcl_hhz76', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

head(b_age)

race_vs_age <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT r.predominant_race, a.age, SUM(a.count) AS total FROM births_by_age a JOIN race_grouping r ON a.year = r.year AND a.zip_code = r.zip_code GROUP BY r.predominant_race, a.age"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_hhz76', PASS='orcl_hhz76', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

head(race_vs_age)

age_grouping <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT ba.year, ba.zip_code, ba.age AS predominant_age_group, foo.high_count AS count, ba.city, ba.state, ba.latitude, ba.longitue AS longitude, ba.location FROM (SELECT year, zip_code, max(count) AS high_count FROM births_by_age GROUP BY year, zip_code) foo JOIN births_by_age ba ON foo.year = ba.year AND foo.zip_code = ba.zip_code AND foo.high_count = ba.count"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_hhz76', PASS='orcl_hhz76', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

race_grouping <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT br.year, br.zip_code, br.race AS predominant_race, foo.high_count AS race_count, br.city, br.state, br.latitude, br.longitude, br.location FROM (SELECT year, zip_code, max(race_count) AS high_count FROM birth_race GROUP BY year, zip_code) foo JOIN birth_race br ON foo.year = br.year AND foo.zip_code = br.zip_code AND foo.high_count = br.race_count"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_hhz76', PASS='orcl_hhz76', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

age_vs_weight <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT a.predominant_age_group, w.birthweight, SUM(w.count) AS total FROM age_grouping a JOIN birth_weights w ON a.year = w.year AND a.zip_code = w.zip_code GROUP BY a.predominant_age_group, w.birthweight"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_hhz76', PASS='orcl_hhz76', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

head(age_vs_weight)

race_vs_weight <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="SELECT r.predominant_race, w.birthweight, SUM(w.count) AS total FROM race_grouping r JOIN birth_weights w ON r.year = w.year AND r.zip_code = w.zip_code GROUP BY r.predominant_race, w.birthweight"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_hhz76', PASS='orcl_hhz76', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

head(race_vs_weight)