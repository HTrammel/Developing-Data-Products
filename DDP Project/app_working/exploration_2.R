library(dplyr)
library(ggplot2)
library(randomForest)
library(gbm)
library(ISLR)

set.seed(1972)

data("Auto")
autos_df <- Auto %>% select(-name)
inTrain <- createDataPartition(autos_df$mpg, p=0.7, list=F)
train_df <- autos_df[inTrain,]
validate_df <- autos_df[-inTrain,]

#rf_fit <- randomForest(mpg ~ ., data=train_df, method="rf", prox=T)
rf_fit <- train(mpg ~ ., data=train_df, method="rf", prox=T)
print(rf_fit)
rf_pl <- qplot(predict(rf_fit,validate_df),mpg,data=validate_df)
print(rf_pl)

boost_fit <- train(mpg ~ ., data=train_df, method="gbm", verbose=F)
#boost_fit <- gbm(mpg ~ ., data=train_df, cv.folds = 10)
print(boost_fit)
b_pl <- qplot(predict(boost_fit,validate_df),mpg,data=validate_df)
print(b_pl)

saveRDS(autos_df, "./app/autos_df.rds")
saveRDS(train_df, "./app/train_df.rds")
saveRDS(validate_df, "./app/validate_df.rds")
saveRDS(rf_fit, "./app/rf_fit.rds")
saveRDS(boost_fit, "./app/boost_fit.rds")

