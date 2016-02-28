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
      
      helpText("Create bar charts with information from NJDOT and the U.S. Census' American Community Survey"),
      # Simple integer interval
      conditionalPanel(condition="input.currentTab=='Accidents by County'",
      selectInput("year", label = h3("Select year:"),
                  choices = c(2008:2014),
                 selected = "2014")
      )
,
      conditionalPanel(
        condition="input.currentTab=='Drunk drivers'",
        selectInput("year2", label = h3("Select year:"),
                    choices = c(2001:2014),
                    selected = 2014),
        selectInput("drunk","Drivers charged with DWI?", choices = c("Yes","No")
        ))
      ),
    # Show a table summarizing the values entered
    mainPanel(
      tabsetPanel(id="currentTab",
      #plotOutput("map"), #commenting out my plotOutput
        tabPanel("Accidents by County",plotOutput("barPlot")),
        tabPanel("Drunk drivers",
                 plotOutput("drunkPlot"),
                 htmlOutput("drunkText")
        )
      )
    )
  )
))