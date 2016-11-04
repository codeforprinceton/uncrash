#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(plotly)

library(shiny)



shinyUI(fluidPage(

  # Application title
  titlePanel("NJ crash Data"),

  # Sidebar with a slider input for number of bins
  sliderInput("year", label = h4("Select year:"),
                  min = 2001, max = 2014, value = 2001, sep="", ticks=FALSE, animate=TRUE),

  plotlyOutput("trendline", width = "100%", height = 900)


  

    # sidebarLayout(
    #   sidebarPanel(
    #     sliderInput("year", label = h4("Select year:"),
    #                 min = 2008, max = 2014, value = 2014, sep="", ticks=FALSE, animate=TRUE)
    #   )
    #   ,
    #   fluidRow(
    #     mainPanel(
    #       plotlyOutput("trendline", width = "100%", height = "100%")
    #     )
    #   ) 
    # )
  

  
  
  # Show a plot of the generated distribution

))
