# app.R
library(shiny)
library(ggplot2)
library(DT)
library(ISLR)
library(dplyr)

palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
          "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))


data("Auto")
Auto <- readRDS("./Auto.rds")
autos_df <- readRDS("./autos_df.rds")
train_df<- readRDS("./train_df.rds")
validate_df<- readRDS("./validate_df.rds")
rf_fit<- readRDS("./rf_fit.rds")
boost_fit<- readRDS("./boost_fit.rds")


server <- (function(input, output, session) {
    selectedData <- reactive({
        autos_df[, c(input$xcol, input$ycol)]
    })

    output$lmplot <- renderPlot({
        pl <- ggplot(autos_df, aes_string(x=input$xcol, y=input$ycol)) +
            geom_point(stat="identity") +
            geom_smooth(method="lm")
        pl_hold <- pl
        if (input$radio1 == "1") { pl <- pl_hold + scale_x_log10() }
        else if (input$radio1 == "2") { pl <- pl_hold + scale_y_log10() }
        else if (input$radio1 == "3") { pl <- pl_hold + scale_x_log10() + scale_y_log10() }
        else {pl <- pl_hold}
        print(pl)

    })
    output$rfplot <- renderPlot({
        if (input$radioGroup == 1) {
            qplot(predict(rf_fit, validate_df), mpg, data=validate_df)
        } else {
            qplot(predict(boost_fit, validate_df), mpg, data=validate_df)
        }
    })

    output$fit_info <- renderPrint({
        if (input$radioGroup == 1) {
            rf_fit
        } else {
            boost_fit
        }
    })

    output$summary <- renderPrint({
        summary(autos_df)
    })

    output$table <- renderDataTable({
        DT::datatable(autos_df)
    })
})


ui <- navbarPage(
    'Auto (ISLR)',
    tabPanel("Regression Plots",
             sidebarLayout(
                 sidebarPanel(
                     selectInput('xcol', 'X Variable', names(autos_df)),
                     selectInput('ycol', 'Y Variable', names(autos_df),
                                 selected = names(autos_df)[[2]]),
                     radioButtons("radio1",
                                  label="Plot with log10 Axis",
                                  choices = list(
                                      "x axis" = "1",
                                      "y axis" = "2",
                                      "both axis" = "3",
                                      "neither" = "0"),
                                  selected = "0"
                    )
                 ),
                 mainPanel(plotOutput("lmplot"))
             )),
    tabPanel("Forest or Boost",
         sidebarLayout(
             sidebarPanel(
                 radioButtons("radioGroup",
                              label = h4("Choose:"),
                              choices = list("random forest" = 1,
                                             "boosted" = 2),
                              selected = 2
                 )
             ),
             mainPanel(
                 plotOutput("rfplot"),
                 verbatimTextOutput("fit_info")
                       )
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
