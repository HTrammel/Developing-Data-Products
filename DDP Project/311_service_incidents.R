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

res_levels <- levels(abuse_df$Resolution.Description)


abrv_levels <- c("Issued summons",
	"Made arrest",
	"Responsible parties were gone",
	"Prepared report",
	"Police action unecessary",
	"Took action to fix condition",
	"No evidence of violation seen",
	"Unable to enter the premises",
	"Provided additional information",
	"Not NYPD jurisdiction",
	"Non-emergency response",
	"Will provide information later",
	"Insufficient contact information")

library(plyr)
abuse_df$Resolution.Description <- mapvalues(abuse_df$Resolution.Description, from = res_levels, to = abrv_levels)
