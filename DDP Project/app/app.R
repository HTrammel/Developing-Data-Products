# app.R
library(dplyr)
library(tidyr)
library(shiny)
library(ggplot2)
library(DT)
library(ISLR)

data("Auto")
autos <- Auto %>% select(-name)


#autos$origin <- as.factor(autos$origin)
palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

server <- (function(input, output, session) {
    selectedData <- reactive({
        autos[, c(input$xcol, input$ycol)]
    })

    clusters <- reactive({
        kmeans(selectedData(), input$clusters)
    })

    output$kplot <- renderPlot({
        par(mar = c(5.1, 4.1, 0, 1))
        plot(selectedData(),
             col = clusters()$cluster,
             pch = 20, cex = 3)
        points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
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

    output$summary <- renderPrint({
        summary(autos)
    })

    output$table <- renderDataTable({
        DT::datatable(autos)
    })
})


ui <- navbarPage('Auto (ISLR)',
    tabPanel("k-means clustering",
        sidebarLayout(
            sidebarPanel(
                selectInput('xcol', 'X Variable', names(autos)),
                selectInput('ycol', 'Y Variable', names(autos),
                        selected=names(autos)[[2]]),
                numericInput('clusters', 'Cluster count', 3,
                         min = 1, max = 9)
            ),
            mainPanel(
                plotOutput('kplot')
            ))),
    tabPanel("Regression Plots",
        sidebarLayout(
            sidebarPanel(
                selectInput('xcol', 'X Variable', names(autos)),
                selectInput('ycol', 'Y Variable', names(autos),
                        selected=names(autos)[[2]])
           ),
            mainPanel(
                plotOutput('lmplot')
            ))),
    tabPanel("Summary",
        verbatimTextOutput("summary")
    ),
    tabPanel("Table",
        DT::dataTableOutput("table")
    ),
    tabPanel("About",
        fluidRow(
            column(6,
                includeMarkdown("about.Rmd")
    )))
)


shinyApp(ui = ui, server = server)
