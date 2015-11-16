library(shiny)

# c("Key",
#    "Open.Date",
#    "Close.Date",
#    "Complaint.Type",
#    "Location.Type",
#    "Incident.Zip",
#    "City",
#    "Incident.Status",
#    "Due.Date",
#    "Resolution.Type",
#    "Resolution.Date",
#    "Borough",
#    "Latitude",
#    "Longitude",
#    "Create_YR",
#    "Create_MO",
#    "Close_YR",
#    "Close_MO")
# ,
# "Location Zipcode" = "Incident.Zip",
# "City" = "City",
# "Status" = "Incident.Status",
# "Resolution" = "Resolution.Type",
# "Resolution Date" = "Resolution.Date",
# "Borough" = "Borough",
# "Latitude" = "Latitude",
# "Longitude" = "Longitude",
# "Complaint Year" = "Create_YR",
# "Complaint Month" ="Create_MO",
# "Close Year" ="Close_YR",
# "Close Month" ="Close_MO"

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

        selectInput("var",
                    "Variable:",
                    list("Complaint Type" = "Complaint.Type",
                       "Location Type" = "Location.Type")
                )
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
