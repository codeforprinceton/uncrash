rm(list = ls())
library(shiny)

# Define UI for slider demo application
shinyUI(fluidPage(
  
  #  Application title
  titlePanel("Crashes by County, NJ"),
  
  # Sidebar with sliders that demonstrate various available
  # options
  sidebarLayout(
    sidebarPanel(
      helpText("Create bar charts with information from NJDOT and the U.S. Census' American Community Survey"),
      # Simple integer interval
      selectInput("year", label = h3("Select year:"),
                  choices = c("2008", "2009", "2010", "2011", "2012", "2013", "2014"),
                 selected = "2014"),
      textOutput("text1")
      ),
    # Show a table summarizing the values entered
    mainPanel(
      #plotOutput("map"), #commenting out my plotOutput
      plotOutput("barPlot")
    )
  )
))