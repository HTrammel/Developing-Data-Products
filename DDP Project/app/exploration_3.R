library(dplyr)
library(ggplot2)
library(caret)
library(ISLR)

data("Auto")
autos <- Auto %>% select(-name)

all_lm <- summary(lm(mpg ~ ., data=autos))
print(all_lm)

some_lm <- summary(lm(mpg ~ weight + year + origin + displacement + horsepower, data=autos))
print(some_lm)
