# Read animal abuse form
library(dplyr)


if(!file.exists("./data")) {dir.create("./data")}
base_df <- read.csv("./data/311_Service_Requests_from_2010_to_Present.csv")

abuse_df <- base_df %>%
            select(-starts_with("School")) %>%
            select(-starts_with("Garage")) %>%
            select(-starts_with("Bridge")) %>%
            select(-starts_with("Taxi")) %>%
            select(-starts_with("Ferry")) %>%
            select(-starts_with("Road")) %>%
            select(-starts_with("Vehicle"))
