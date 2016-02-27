library(shiny)
source("helpers.R")
#counties <- readRDS("data/counties.rds") #Commented out until I try map thing again

library(maps)
library(mapproj)
# Define server logic for slider examples
shinyServer(function(input, output) {

  ####NEED TO UPDATE MY SERVER CODE -- WYLIE  
  # Reactive expression to compose a data frame containing all of
  # the values
  output$text1 <- renderText({
      paste("You have selected", input$year)
  })
  
  output$map <- renderPlot({
    data <- switch(input$year,
                   "2014" = counties$white,
                   "2013" = counties$black,
                   "2012" = counties$hispanic,
                   "2011" = counties$asian,
                   "2010" = counties$white,
                   "2009" = counties$white,
                   "2008" = counties$white)
    legend <- switch(input$year,
                   "2014" = "2014",
                   "2013" = "2013",
                   "2012" = "2012",
                   "2011" = "2011",
                   "2010" = "2010",
                   "2009" = "2009",
                   "2008" = "2008")
    percent_map (var = data, #var is equal to a column vector from the dataset
                 color = "darkorange", #any character string from colors()
                 legend.title = legend, #should have this be the year pr
                 max = 100, #hard coded for now
                 min = 0)
  })
  })

  output$barPlot <- renderPlot({
    barplot(#ACSdata[,#input$region],
    main=#input$region,
    horiz=TRUE,
    ylab="Y var",
    xlab="County")
  })