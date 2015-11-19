library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(caret)
library(mlbench)
library(ISLR)


data("Auto")
autos <- Auto

par(mar = c(5.1, 4.1, 0, 1))
plot(autos$mpg ~ autos$displacement,
        col = "red",
        pch = 20,
        cex = 2)
lines(lowess(autos$mpg ~ autos$displacement),
      col = "blue",
      lwd = 3)


