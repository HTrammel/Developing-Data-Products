# app.R
library(dplyr)
library(tidyr)
library(shiny)
library(ggplot2)
library(car)

data("Angell")
angell <- Angell
df <- cbind(angell, city = rownames(df))

server <- (function(input, output) {
    output$plot <- renderPlot({
        y <- input$var
        ggplot(df, aes(moral,y))+geom_bar()
    })
})


ui <- fluidPage(
    titlePanel("Moral Integration of American Cities"),
    sidebarLayout(
        sidebarPanel(
            radioButtons(
                "var", "Variable:",
                c(
                    "City" = "city",
                    "Ethnic Heterogenity" = "hetero",
                    "Geographic Mobility" = "mobility",
                    "Geographic Region" = "region"
                )
    )),
    mainPanel(plotOutput("plot")))
)




shinyApp(ui = ui, server = server)

# checkboxGroupInput("var", "Variable:",
#                    c("Ethnic Heterogenity" = "hetero",
#                      "Geographic Mobility" = "mobility",
#                      "Geographic Region" = "region"))
