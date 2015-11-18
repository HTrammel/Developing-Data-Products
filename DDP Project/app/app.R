# app.R
library(dplyr)
library(tidyr)
library(shiny)
library(ggplot2)
library(ISLR)

data("Auto")
autos <- Auto
#autos$origin <- as.factor(autos$origin)

server <- (function(input, output) {
    output$plot <- renderPlot({
        plot(autos$mpg ~ autos[,input$var])
    })

    output$summary <- renderPrint({
        summary(autos)
    })

    output$table <- renderTable({
        data.frame(autos)
    })
})


ui <- fluidPage(
    titlePanel("Automobile Data (ISLR)"),
    sidebarLayout(sidebarPanel(radioButtons(
        "var", "Variable:",
        c(
            "Cylinders" = "cylinders",
            "Displacement" = "displacement",
            "Horsepower" = "horsepower",
            "Weight" = "weight",
            "Acceleration" = "acceleration",
            "Year" = "year",
            "Origin" = "origin"
        )
    )),
    mainPanel(
        tabsetPanel(
            tabPanel("Plot", plotOutput("plot")),
            tabPanel("Summary", verbatimTextOutput("summary")),
            tabPanel("Table", tableOutput("table"))
        )
    ))
)




shinyApp(ui = ui, server = server)

# checkboxGroupInput("var", "Variable:",
#                    c("Ethnic Heterogenity" = "hetero",
#                      "Geographic Mobility" = "mobility",
#                      "Geographic Region" = "region"))
