library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(caret)
library(mlbench)
library(ISLR)

autos_df <- readRDS("./app/autos_df.rds")


par(mar = c(5.1, 4.1, 0, 1))
plot(autos_df$mpg ~ autos_df$displacement,
     col = "red",
     pch = 20,
     cex = 2)
lines(lowess(autos_df$mpg ~ autos_df$displacement),
      col = "blue",
      lwd = 3)
