#server.R

library(shiny)
library(ggplot2)
library(DT)
library(caret)
library(randomForest)
library(gbm)
#library(ISLR)
library(dplyr)

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

set.seed(1972)
# data("Auto")
# autos_df  <- Auto %>% select(-name)
#
# inTrain <- createDataPartition(autos_df$mpg, p=0.7, list=F)
# train_df <- autos_df[inTrain,]
# validate_df <- autos_df[-inTrain,]
#
#
# rf_fit <- train(mpg ~ ., data=train_df, method="rf", prox=T)
# boost_fit <- train(mpg ~ ., data=train_df, method="gbm", verbose=F)

setwd(".")
Auto <- readRDS("./Auto.rds")
autos_df <- readRDS("./autos_df.rds")
train_df<- readRDS("./train_df.rds")
validate_df<- readRDS("./validate_df.rds")
rf_fit<- readRDS("./rf_fit.rds")
boost_fit<- readRDS("./boost_fit.rds")

shinyServer(function(input, output, session) {
    selectedData <- reactive({
        autos_df[, c(input$xcol, input$ycol)]
    })

    output$lmplot <- renderPlot({
        pl <- ggplot(autos_df, aes_string(x = input$xcol, y = input$ycol)) +
            geom_point(stat = "identity") +
            geom_smooth(method = "lm")
        pl_hold <- pl
        if (input$radio1 == "1") {
            pl <- pl_hold + scale_x_log10()
        }
        else if (input$radio1 == "2") {
            pl <- pl_hold + scale_y_log10()
        }
        else if (input$radio1 == "3") {
            pl <- pl_hold + scale_x_log10() + scale_y_log10()
        }
        else {
            pl <- pl_hold
        }
        print(pl)
    })

    output$rfplot <- renderPlot({
        if (input$radioGroup == "1") {
            qplot(predict(rf_fit, validate_df), mpg, data = validate_df)
        } else {
            qplot(predict(boost_fit, validate_df), mpg, data = validate_df)
        }
    })

    output$fit_info <- renderPrint({
        if (input$radioGroup == "1") {
            rf_fit
        } else {
            boost_fit
        }
    })

    output$summary <- renderPrint({
        summary(autos_df)
    })

    output$table <- renderDataTable({
        DT::datatable(Auto)
    })
})
