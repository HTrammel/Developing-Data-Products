library(dplyr)
library(tidyr)
library(lubridate)
library(ggplot2)
library(caret)
library(mlbench)
library(car)


data("Angell")
angell <- Angell
df <- cbind(angell, city = rownames(df))

print(summary(df))

mor_pl <- ggplot(df, aes(moral)) +
            geom_histogram(stat="bin")
print(mor_pl)

het_pl <- ggplot(df, aes(hetero)) +
    geom_histogram(stat="bin")
print(het_pl)

mob_pl <- ggplot(df, aes(mobility)) +
    geom_histogram(stat="bin")
print(mob_pl)

reg_pl <- ggplot(df, aes(region)) +
    geom_histogram(stat="bin")
print(reg_pl)
