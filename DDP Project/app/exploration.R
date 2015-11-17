library(dplyr)
library(lubridate)
library(ggplot2)
library(caret)
library(mlbench)
library(car)

data("Angell")

angell <- Angell

mor_pl <- ggplot(angell, aes(moral)) +
            geom_histogram()
print(mor_pl)

het_pl <- ggplot(angell, aes(hetero)) +
    geom_histogram(stat="bin")
print(het_pl)

mob_pl <- ggplot(angell, aes(mobility)) +
    geom_histogram()
print(mob_pl)

reg_pl <- ggplot(angell, aes(region)) +
    geom_histogram()
print(reg_pl)
