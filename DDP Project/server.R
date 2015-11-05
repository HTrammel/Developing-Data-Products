# server.R
#
# version 1
#

library(shiny)

server <- function(input, output) {
    output$hist <- renderPlot({
        hist(rnorm(input$num))
    })
}
