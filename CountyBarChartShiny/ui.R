rm(list = ls())
library(shiny)

# Define UI for slider demo application
shinyUI(fluidPage(
  
  #  Application title
  titlePanel("NJ Crash Data Visualization"),
  
  # Sidebar with sliders that demonstrate various available
  # options
  sidebarLayout(
    sidebarPanel(
      
      helpText("Visualize traffic incidents by county with information from NJDOT and the U.S. Census' American Community Survey"),
      # Simple integer interval
      conditionalPanel(condition="input.currentTab=='Accidents by County'",
      sliderInput("year", label = h3("Select year:"),
      min = 2008, max = 2014, value = 2014, sep="", ticks=FALSE, animate=TRUE))  
,
      conditionalPanel(
        condition="input.currentTab=='Drunk drivers'",
          sliderInput("year2", label= h3("Select year:"),
            min = 2008, max = 2014, value = 2014, sep="", ticks=FALSE, animate=TRUE),
#         selectInput("year2", label = h3("Select year:"),
#                     choices = c(2001:2014),
#                     selected = 2014),
        selectInput("drunk","Drivers charged with DWI?", choices = c("Yes","No")
        ))
      ),
    # Show a table summarizing the values entered
    mainPanel(
      tabsetPanel(id="currentTab",
      #plotOutput("map"), #commenting out my plotOutput
        tabPanel("Accidents by County",plotOutput("barPlot")),
        tabPanel("Drunk drivers",
                 plotOutput("drunkPlot")
                 )
      )
    )
  )
))