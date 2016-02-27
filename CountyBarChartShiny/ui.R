library(shiny)

# Define UI for slider demo application
shinyUI(fluidPage(
  
  #  Application title
  titlePanel("New"),
  
  # Sidebar with sliders that demonstrate various available
  # options
  sidebarLayout(
    sidebarPanel(
      # Simple integer interval
      sliderInput("integer", "Integer:",
                  min=0, max=2008, value=2014)),
    
    # Show a table summarizing the values entered
    mainPanel(
      tableOutput("values")
    )
  )
))