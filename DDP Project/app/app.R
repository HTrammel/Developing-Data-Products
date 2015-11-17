# app.R

library(shiny)
library(ggplot2)
library(car)

angell <- data("Angell")


ui <- navbarPage("Moral Integration of American Cities!",
        tabPanel("Plot",
            sidebarLayout(
                sidebarPanel(
                    radioButtons("var", "Variable:",
                        c("Ethnic Heterogenity" = "hetero",
                            "Geographic Mobility" = "mobility",
                            "Geographic Region" = "region")
                    )
                ),
                mainPanel( plotOutput("plot") )
            )
        ),
    tabPanel("Summary", verbatimTextOutput("summary") ),
    tabPanel("Table", verbatimTextOutput("table") ),
    tabPanel("About", verbatimTextOutput("about") )
)

server <- (function(input, output) {
    output$plot <- renderPlot({
        formula <- paste("x=moral, y=", input$var)
        ggplot(angell, aes(formula)) + geom_point()
    })

    output$summary <- renderPrint({
        summary(cars)
    })

    output$table <- renderDataTable({
        cars
    }, options = list(pageLength = 10))
})


shinyApp(ui = ui, server = server)

# checkboxGroupInput("var", "Variable:",
#                    c("Ethnic Heterogenity" = "hetero",
#                      "Geographic Mobility" = "mobility",
#                      "Geographic Region" = "region"))
