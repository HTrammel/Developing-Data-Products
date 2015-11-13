# Read animal abuse form
library(dplyr)
library(lubridate)


if(!file.exists("./data")) {dir.create("./data")}
base_df <- read.csv("./data/Animal_Abuse_Complaints.csv",na.strings = "NA")

abuse_df <- base_df %>%
            select(-starts_with("School")) %>%
            select(-starts_with("Garage")) %>%
            select(-starts_with("Bridge")) %>%
            select(-starts_with("Taxi")) %>%
            select(-starts_with("Ferry")) %>%
            select(-starts_with("Road")) %>%
            select(-starts_with("Vehicle"))

abuse_df$Created.Date <-  as.POSIXlt(as.character(abuse_df$Created.Date))
abuse_df$Closed.Date <- as.character(abuse_df$Closed.Date)


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
