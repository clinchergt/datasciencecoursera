#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(data.table)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  data(mtcars)
  mtcars <- setDT(mtcars)
  set.seed(4242)
  
  output$distPlot <- renderPlot({
    
    updateCars <- reactive({
      clusters <- kmeans(mtcars[, .(mpg, hp)], input$clusters)
      mtcars[, cluster := clusters$cluster]
      
      mtcars
    })
    
    updateField <- reactive({
      input$fields
    })
    
    mtcars <- updateCars()
    contrastField <- updateField()
    
    ggplot(mtcars, aes_string(contrastField)) +
      geom_point(aes(y=mpg, color=factor(cluster)), size=4) +
      labs(title=paste("Car MPG depending on", toupper(contrastField)),
           x=toupper(contrastField),
           y="MPG",
           color="Cluster")
    
  })
  
})
