#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("MPG Clusters"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       selectInput("fields",
                   "Variable to contrast MPG to:",
                   names(mtcars)[2:11],
                   selected = "hp"),
       br(),
       sliderInput("clusters",
                   "Number of clusters:",
                   min = 1,
                   max = 10,
                   value = 2),
       br(),
       h3("Dictionary of variables:"),
       strong("mpg:"), span("Miles/(US) gallon"),
       br(), strong("cyl:"), span("Number of cylinders"),
       br(), strong("disp:"), span("Displacement (cu.in.)"),
       br(), strong("hp:"), span("Gross horsepower"),
       br(), strong("drat:"), span("Rear axle ratio"),
       br(), strong("wt:"), span("Weight (1000 lbs)"),
       br(), strong("qsec:"), span("1/4 mile time"),
       br(), strong("vs:"), span("Engine (0 = V-shaped, 1 = straight)"),
       br(), strong("am:"), span("Transmission (0 = automatic, 1 = manual)"),
       br(), strong("gear:"), span("Number of forward gears"),
       br(), strong("carb:"), span("Number of carburetors")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot"),
       
       h1("What is MPG Clusters?"),
       p("This is an exploratory data analysis (EDA) app that allows you to assess data from the famous `mtcars` data by allowing you to set what variables you want to contraste and how many clusters you want to create."),
       h3("What does that name even mean?"),
       p("First we have to define a few terms. MPG means (US) Miles per gallon. What does cluster mean? A cluster is a group of data points defined either manually of algorithmically (systematically, automatically)."),
       p("So what this app does is let you compare different variables to the overall MPG a car would have. The comparison is done by plotting the selected variable against the resulting MPG."),
       h3("How does this work and what do the controls even do?"),
       p("First you need to realize that clustering is done in a 2-dimensional space in this app. This means that we need another (a second variable) variable to compare MPG against. This is what the first control does (the select/combo box)"),
       p("The second control is all about how many clusters you want your data to be segmented in. This is all in the user's control and is usually set empirically as to what is optimal. This is a visualization tool though, which means it will help you explore the data at your own pace using your own criteria. For this reason we allow the number of clusters to be set."),
       br()
    )
  )
))
