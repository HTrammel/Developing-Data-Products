library(shiny)
library(rCharts)

nyc_df <- readRDS("./data/abuse_df.rds")

shinyServer(function(input, output) {

    formulaText <- reactive({
        paste("Location ~", input$var)
    })

    output$plot <- renderPlot({
        boxplot(as.formula(formulaText()),
                data = nyc_df)
    })

    # Generate a summary of the data
    output$summary <- renderPrint({
        summary(data())
    })

    # Generate an HTML table view of the data
    output$table <- renderTable({
        data.frame(x=data())
    })

    # Generate an HTML table view of the data
    output$map <- renderPlot({
        data.frame(x=data())
    })

})
