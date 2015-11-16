library(dplyr)
library(lubridate)
library(ggplot2)
library(caret)
library(mlbench)


nyc_df <- readRDS("./data/abuse_df.rds")
#nyc_df$Complaint.Type <- as.factor(nyc_df$Complaint.Type)

date_df <- nyc_df %>%
    select(one_of(c("Complaint.Type",
                    "Location.Type",
#                     "Incident.Zip",
#                     "City",
#                     "Incident.Status",
                    "Resolution.Type",
                    "Borough",
                    "Create_YR",
                    "Create_MO"
# , "Create_Wday"
                    ))) %>%
    group_by(   Complaint.Type,
                Resolution.Type,
                Create_YR,
                Create_MO
            ) %>%
    count()

pl <- ggplot(date_df, aes(x="Complaint.Type", y="Resolution.Type")) +
      geom_point()
print(pl)




#
# # ensure the results are repeatable
# set.seed(7)
# # calculate correlation matrix
# correlationMatrix <- cor(nyc_df)
# # summarize the correlation matrix
# print(correlationMatrix)
# # find attributes that are highly corrected (ideally >0.75)
# highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.5)
# # print indexes of highly correlated attributes
# print(highlyCorrelated)
#
