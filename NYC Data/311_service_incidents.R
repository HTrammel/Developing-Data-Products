# Read animal abuse form
library(dplyr)
library(lubridate)
library(plyr)

# read data from file
if(!file.exists("./data")) {dir.create("./data")}
base_df <- read.csv("./data/Animal_Abuse_Complaints.csv",na.strings = "NA")

# convert dates from factors to POSIXlt
base_df$Created.Date <- parse_date_time(as.character(base_df$Created.Date), orders="mdy hms")
base_df$Closed.Date <- parse_date_time(as.character(base_df$Closed.Date), orders="mdy hms")

base_df$create_yr <- year(base_df$Created.Date)
base_df$create_mon <- month(base_df$Created.Date, label = TRUE, abbr = TRUE)
base_df$create_mo <- month(base_df$Created.Date)
base_df$create_wday <- wday(base_df$Created.Date, label = TRUE, abbr = TRUE)

base_df$close_yr <- year(base_df$Closed.Date)
base_df$close_mon <- month(base_df$Closed.Date, label = TRUE, abbr = TRUE)
base_df$close_wday <- wday(base_df$Closed.Date, label = TRUE, abbr = TRUE)

# remove unneeded columns
abuse_df <- base_df %>%
    select(one_of(c("Descriptor",
                    "Location.Type",
                    "Incident.Zip",
                    "City",
                    "Status",
                    "Resolution.Description",
                    "Borough",
                    "create_yr",
                    "create_mon",
                    "create_mo",
                    "create_wday",
                    "close_yr",
                    "close_mon",
                    "close_wday"))) %>%
    mutate(cnt=1)

abuse_df$Incident.Zip <- as.factor(abuse_df$Incident.Zip)

# convert resolution data into usable form
res_levels <- levels(abuse_df$Resolution.Description)

abrv_levels <- c("Issued summons",
	"Made arrest",
	"Responsible parties gone",
	"Prepared report",
	"Police action unecessary",
	"Took action to fix condition",
	"No evidence of violation",
	"Unable to enter premises",
	"Provided additional info",
	"Not NYPD jurisdiction",
	"Non-emergency response",
	"Will provide info later",
	"Insuff. contact info")

abuse_df$Resolution.Description <- mapvalues(abuse_df$Resolution.Description,
                                             from = res_levels,
                                             to = abrv_levels)

new_names <- c("Complaint.Type",
               "Location.Type",
               "Incident.Zip",
               "City",
               "Incident.Status",
               "Resolution.Type",
               "Borough",
               "Create_YR",
               "Create_MON",
               "Create_MO",
               "Create_Wday",
               "Close_YR",
               "Close_MON",
               "Close_Wday",
               "Count")
names(abuse_df) <- new_names

# save data frome for future use
saveRDS(abuse_df, "./app/data/abuse_df.rds")

