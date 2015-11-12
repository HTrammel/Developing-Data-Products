library(RSocrata)
library(dplyr)

baseURL <- "http://data.cityofnewyork.us/"
df <- ls.socrata(baseURL)
url_311 <- df[135,"landingPage"]

df_311 <- read.socrata(url_311)
saveRDS(df_311,"./data/df_311.rds")
