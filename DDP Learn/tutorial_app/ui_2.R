# ui.R

shinyUI(fluidPage(
    titlePanel("My Shiny App"),

    sidebarLayout(
        sidebarPanel(
        	h2("Installation"),
        	p("Shiny is available on CRAN,
        	so you can install it in the usual way
        	from your R console:"),
        	code("install.packages(\"shiny\")"),
        	br(),br(),br(),
        	img(src="bigorb.png", height = 50, width = 50),
        	"shiny is a product of", span("RStudio", style ="color:blue")
        	),
        mainPanel(
        	h1("Introducing Shiny"),
        	p("Shiny iS a new pacakge from RStudion that makes it ",
        	em("incredibly east"),
        	" to build interactive web applications with R"),
        	br(),
        	 p("For an introduction and live examples, visit the ",
        a("Shiny homepage.", 
          href = "http://www.rstudio.com/shiny")),
        	br(),
        	h2("Features"),
        	p("* Build useful web applications with only a few lines of code -- no JavaScript required"),
        	p("* Shiny applications are automatically \"live\" int he same way that ",
        		strong("spreadsheets"),
        		"are live.  Out ")
        	)
    )
))

