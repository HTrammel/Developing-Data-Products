library(dplyr)
library(ggplot2)
library(caret)
library(ISLR)

data("Auto")
autos <- Auto %>% select(-name)

set.seed(1972)

inTrain <- createDataPartition(autos$mpg, p=0.7, list=F)
train_df <- autos[inTrain,]
validate_df <- autos[-inTrain,]

modfit <- train(mpg ~ ., data=train_df, method="rf", prox=T)
print(modfit)
rf_pl <- qplot(predict(modfit,validate_df),mpg,data=validate_df)
print(rf_pl)

rf_pd <- predict(modfit,validate_df)
rf_cm <- confusionMatrix(rf_pd, validate_df$mpg)
print(rf_cm)

boostfit <- train(mpg ~ ., data=train_df, method="gbm", verbose=F)
print(boostfit)
b_pl <- qplot(predict(boostfit,validate_df),mpg,data=validate_df)
print(b_pl)

b_pd <- predict(boostfit,validate_df)
b_cm <- confusionMatrix(b_pd, validate_df$mpg)

print(b_cm)
