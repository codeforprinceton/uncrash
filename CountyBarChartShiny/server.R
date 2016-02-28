rm(list = ls())
library(shiny)
library(ggplot2)
load("alcohol.Rdata")
#source("helpers.R")
#counties <- readRDS("data/counties.rds") #Commented out until I try map thing again
#loading me data
acs2014 <- readRDS("data/ACS2014.rds")
acs2013 <- readRDS("data/ACS2013.rds")
acs2012 <- readRDS("data/ACS2012.rds")
acs2011 <- readRDS("data/ACS2011.rds")
acs2010 <- readRDS("data/ACS2010.rds")
acs2009 <- readRDS("data/ACS2009.rds")
acs2008 <- readRDS("data/ACS2008.rds")
library(maps)
library(mapproj)
# acs2014 <- readRDS("CountyBarChartShiny/data/ACS2014.rds")
# acs2013 <- readRDS("CountyBarChartShiny/data/ACS2013.rds")
# acs2012 <- readRDS("CountyBarChartShiny/data/ACS2012.rds")
# acs2011 <- readRDS("CountyBarChartShiny/data/ACS2011.rds")
# acs2010 <- readRDS("CountyBarChartShiny/data/ACS2010.rds")
# acs2009 <- readRDS("CountyBarChartShiny/data/ACS2009.rds")
# acs2008 <- readRDS("CountyBarChartShiny/data/ACS2008.rds")
#library(maps)
#library(mapproj)
# Define server logic for slider examples
shinyServer(function(input, output) {

  ####NEED TO UPDATE MY SERVER CODE -- WYLIE  
  # Reactive expression to compose a data frame containing all of
  # the values
  output$text1 <- renderText({
      paste("You have selected", input$year)
  })
  
#   output$map <- renderPlot({
#     data <- switch(input$year,
#                    "2014" = acs2014$`Population Density (per sq. mile) ` ,
#                    "2013" = acs2013$`Population Density (per sq. mile) ` ,
#                    "2012" = acs2012$`Population Density (per sq. mile) ` ,
#                    "2011" = acs2011$`Population Density (per sq. mile) ` ,
#                    "2010" = acs2010$`Population Density (per sq. mile) ` ,
#                    "2009" = acs2009$`Population Density (per sq. mile) ` ,
#                    "2008" = acs2008$`Population Density (per sq. mile) ` )
#     legend <- switch(input$year,
#                    "2014" = "2014",
#                    "2013" = "2013",
#                    "2012" = "2012",
#                    "2011" = "2011",
#                    "2010" = "2010",
#                    "2009" = "2009",
#                    "2008" = "2008")
#     percent_map (var = data, #var is equal to a column vector from the dataset
#                  color = "darkorange", #any character string from colors()
#                  legend.title = legend, #should have this be the year pr
#                  max = 100, #hard coded for now
#                  min = 0)
#   })
#  
  output$barPlot <- renderPlot({
    yearslider <- as.character(input$year)
     data <- switch(yearslider,
                   "2014" = acs2014, #$`Population Density (per sq. mile) ` ,
                   "2013" = acs2013, #$`Population Density (per sq. mile) ` ,
                   "2012" = acs2012, #$`Population Density (per sq. mile) ` ,
                   "2011" = acs2011, #$`Population Density (per sq. mile) ` ,
                   "2010" = acs2010, #$`Population Density (per sq. mile) ` ,
                   "2009" = acs2009, #$`Population Density (per sq. mile) ` ,
                   "2008" = acs2008) #$`Population Density (per sq. mile) ` ),
    legend <- switch(yearslider,
                   "2014" = "2014 Traffic Incidents per Person per Square Mile",
                   "2013" = "2013 Traffic Incidents per Person per Square Mile",
                   "2012" = "2012 Traffic Incidents per Person per Square Mile",
                   "2011" = "2011 Traffic Incidents per Person per Square Mile",
                   "2010" = "2010 Traffic Incidents per Person per Square Mile",
                   "2009" = "2009 Traffic Incidents per Person per Square Mile",
                   "2008" = "2008 Traffic Incidents per Person per Square Mile")
    ggplot(data = data, aes(x=`Name.of.Area`, y=`incdensity`)) + geom_bar(stat="identity") + coord_flip()  + theme_minimal() + labs(title= legend)
  })
  
  output$drunkPlot <- renderPlot ({
    
    slices <-       c(alcohol$men[alcohol$year==input$year2  & alcohol$alcohol==input$drunk],
                      alcohol$women[alcohol$year==input$year2  & alcohol$alcohol==input$drunk])
    lbls <- c(
      paste0("men: ",
            round(slices[1]/(slices[1]+slices[2])*100),"%"),
      paste0("women: ",
            round(slices[2]/(slices[1]+slices[2])*100),"%")
    )
    pie(slices, labels = lbls, main=
          paste0("Average age: ",
            round(alcohol$age[alcohol$year==input$year2 & alcohol$alcohol==input$drunk],2)
          , " years\n\n",
          "% of accident drivers who were charged with a DWI: ",
          round(
          (alcohol$men[alcohol$year==input$year2  & alcohol$alcohol=="Yes"]+
            alcohol$women[alcohol$year==input$year2  & alcohol$alcohol=="Yes"])/
            (alcohol$men[alcohol$year==input$year2  & alcohol$alcohol=="No"]+
               alcohol$women[alcohol$year==input$year2  & alcohol$alcohol=="No"])*100,2),"%"
            
            
          
          ))
  })

})


