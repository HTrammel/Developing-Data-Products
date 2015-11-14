library(shiny)

# Define UI for random distribution application
shinyUI(fluidPage(

    # Application title
    titlePanel("NYC Animal Abuse Complaints"),

    # Sidebar with controls to select the random distribution type
    # and number of observations to generate. Note the use of the
    # br() element to introduce extra vertical spacing
    sidebarLayout(
        sidebarPanel(
            helpText("Select factor"),
      
        selectInput("var", "Variable:",
                list("Cylinders" = "cyl", 
                     "Transmission" = "am", 
                     "Gears" = "gear")),

    checkboxInput("outliers", "Show outliers", FALSE)
            choices = c("Descriptor", "Location.Type",
              "Resolution.Description", "Borough"),
            selected = "Descriptor"),
                br(),

            sliderInput("n",
                        "Number of observations:",
                        value = 500,
                        min = 1,
                        max = 1000)
        ),

        # Show a tabset that includes a plot, summary, and table view
        # of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Plot", plotOutput("plot")),
                        tabPanel("Summary", verbatimTextOutput("summary")),
                        tabPanel("Table", tableOutput("table")),
                        tabPanel("Map", tableOutput("map"))
            )
        )
    )
))
