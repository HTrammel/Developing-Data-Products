library(dplyr)
library(ggplot2)
library(caret)
library(ISLR)

data("Auto")
autos_df <- Auto %>% select(-name)

all_lm <- summary(lm(mpg ~ ., data=autos_df))
print(all_lm)

some_lm <- summary(lm(mpg ~ weight + year + origin + displacement + horsepower, data=autos_df))
print(some_lm)
