# app.R
library(dplyr)
library(shiny)
library(DT)
library(ISLR)

data("Auto")
autos <- Auto %>% select(-name)

server <- (function(input, output, session) {
    selectedData <- reactive({
        autos[, c(input$xcol, input$ycol)]
    })

    output$lmplot <- renderPlot({
        plot(selectedData(),
             col = "red",
             pch = 20,
             cex = 2)
        lines(lowess(selectedData()),
              col = "blue",
              lwd = 3)
    })
})


ui <- navbarPage('Auto (ISLR)',
    tabPanel("Regression Plots",
        sidebarLayout(
          sidebarPanel(
              selectInput('xcol', 'X Variable', names(autos)),
              selectInput('ycol', 'Y Variable', names(autos),
                          selected=names(autos)[[2]])
          ),
          mainPanel(
              plotOutput('lmplot')
          )))
)


shinyApp(ui = ui, server = server)
