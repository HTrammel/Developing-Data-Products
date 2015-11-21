# ui.R

library(shiny)
library(ggplot2)
library(DT)
library(caret)
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

Auto <- readRDS("./Auto.rds")
autos_df <- readRDS("./autos_df.rds")
train_df<- readRDS("./train_df.rds")
validate_df<- readRDS("./validate_df.rds")
rf_fit<- readRDS("./rf_fit.rds")
boost_fit<- readRDS("./boost_fit.rds")

shinyUI(navbarPage(
    ui <- navbarPage(
        'Auto (ISLR) Analysis',
        tabPanel("Regression Plots",
                 sidebarLayout(
                     sidebarPanel(
                         selectInput('xcol', 'X Variable', names(autos_df)),
                         selectInput('ycol', 'Y Variable', names(autos_df),
                                     selected = names(autos_df)[[2]]),
                         radioButtons(
                             "radio1",
                             label = "Plot with log10 Axis",
                             choices = list(
                                 "x axis" = "1",
                                 "y axis" = "2",
                                 "both axis" = "3",
                                 "neither" = "0"
                             ),
                             selected = "0"
                         )
                     ),
                     mainPanel(plotOutput("lmplot"))
                 )),
        tabPanel("Forest or Boost",
                 sidebarLayout(
                     sidebarPanel(
                         radioButtons(
                             "radioGroup",
                             label = h4("Choose:"),
                             choices = list("random forest" = "1",
                                            "boosted" = "2"),
                             selected = "2"
                         )
                     ),
                     mainPanel(plotOutput("rfplot"),
                               verbatimTextOutput("fit_info"))
                 )),
        tabPanel("Summary",
                 verbatimTextOutput("summary")),
        tabPanel("Table",
                 DT::dataTableOutput("table")),
        tabPanel("Help",
                 fluidRow(column(
                     6,
                     includeMarkdown("help.Rmd")
                 ))),
        tabPanel("About",
                 fluidRow(column(
                     6,
                     includeMarkdown("about.Rmd")
                 )))
    )
))
