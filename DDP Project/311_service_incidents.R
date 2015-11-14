# Read animal abuse form
library(dplyr)
library(lubridate)


if(!file.exists("./data")) {dir.create("./data")}
base_df <- read.csv("./data/Animal_Abuse_Complaints.csv",na.strings = "NA")

abuse_df <- base_df %>%
    select(-Landmark) %>%
    select(-Community.Board) %>%
    select(-Street.Name) %>%
    select(-contains("Coordinate")) %>%
    select(-contains("Address")) %>%
    select(-starts_with("Agency")) %>%
    select(-starts_with("Facility")) %>%
    select(-starts_with("Cross")) %>%
    select(-starts_with("Intersection")) %>%
    select(-starts_with("Complaint")) %>%
    select(-starts_with("School")) %>%
    select(-starts_with("Garage")) %>%
    select(-starts_with("Bridge")) %>%
    select(-starts_with("Taxi")) %>%
    select(-starts_with("Ferry")) %>%
    select(-starts_with("Park")) %>%
    select(-starts_with("Road")) %>%
    select(-Location) %>%
    select(-starts_with("Vehicle"))

abuse_df$Created.Date <- parse_date_time(as.character(abuse_df$Created.Date), orders="mdy hms")
abuse_df$Closed.Date <- parse_date_time(as.character(abuse_df$Closed.Date), orders="mdy hms")
abuse_df$Due.Date <- parse_date_time(as.character(abuse_df$Due.Date), orders="mdy hms")
abuse_df$Resolution.Action.Updated.Date <- parse_date_time(as.character(abuse_df$Resolution.Action.Updated.Date), orders="mdy hms")

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

new_names <- c("Key",
               "Open.Date",
               "Close.Date",
               "Complaint.Type",
               "Location.Type",
               "Incident.Zip",
               "City",
               "Incident.Status",
               "Due.Date",
               "Resolution.Type",
               "Resolution.Date",
               "Borough",
               "Latitude",
               "Longitude")
names(abuse_df) <- new_names

saveRDS(abuse_df, "./data/abuse_df.rds")
