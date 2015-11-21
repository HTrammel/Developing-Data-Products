# app.R
library(dplyr)
library(tidyr)
library(shiny)
library(ggplot2)
library(DT)
library(ISLR)

data("Auto")
saveRDS(Auto, "Auto.rds")
autos <- Auto %>% select(-name)

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

server <- (function(input, output, session) {
    selectedData <- reactive({
        autos[, c(input$xcol, input$ycol)]
    })

    output$lmplot <- renderPlot({
        pl <- ggplot(autos, aes_string(x=input$xcol, y=input$ycol)) +
                geom_point(stat="identity") +
                geom_smooth(method="lm")

        if (input$checkGroup == "y") { pl + scale_y_log10() } else {pl}
        if (input$checkGroup == "x") { pl + scale_y_log10() } else {pl}
        if (input$checkGroup == "a") { pl + scale_y_log10() } else {pl}
        print(pl)
    })
    output$summary <- renderPrint({
        summary(autos)
    })

    output$table <- renderDataTable({
        DT::datatable(Auto)
    })
})


ui <- navbarPage(
    'Auto (ISLR)',
    tabPanel("Regression Plots",
             sidebarLayout(
                 sidebarPanel(
                     selectInput('xcol', 'X Variable', names(autos)),
                     selectInput('ycol', 'Y Variable', names(autos),
                                 selected = names(autos)[[2]]),
                     checkboxGroupInput(
                         "checkGroup",
                         label = h4("Log Axis"),
                         choices = list("y axis" = "y",
                                        "x axis" = "x",
                                        "none" = "a"),
                            selected = "a"
                     )
                 ),
                 mainPanel(plotOutput('lmplot'))
             )),
    tabPanel("Summary",
             verbatimTextOutput("summary")),
    tabPanel("Table",
             DT::dataTableOutput("table")),
    tabPanel("About",
             fluidRow(column(
                 6,
                 includeMarkdown("about.Rmd")
             )))
)


shinyApp(ui = ui, server = server)

# clusters <- reactive({
#     kmeans(selectedData(), input$clusters)
# })

# output$kplot <- renderPlot({
#     par(mar = c(5.1, 4.1, 0, 1))
#     plot(selectedData(),
#          col = clusters()$cluster,
#          pch = 20, cex = 3)
#     points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
# })

# sidebarLayout(
#     sidebarPanel(
#         selectInput('xcol', 'X Variable', names(autos)),
#         selectInput('ycol', 'Y Variable', names(autos),
#                 selected=names(autos)[[2]]),
#         numericInput('clusters', 'Cluster count', 3,
#                  min = 1, max = 9)
#     ),
#     mainPanel(
#         plotOutput('kplot')
#     ))),

