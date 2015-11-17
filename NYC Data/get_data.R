# get_data.R

library(httr)

if(!file.exists("./data")) {dir.create("./data")}


fileUrl <- "https://data.cityofnewyork.us/api/views/erm2-nwe9/rows.csv?accessType=DOWNLOAD"
nyc_data <- "./data/311_Service_Requests_from_2010_to_Present.csv"
download.file(fileUrl, destfile = nyc_data, method = "wininet")
list.files("./data")

df_311 <- read.csv(nyc_data)
