rm(list = ls())
library(shiny)
library(ggplot2)
require(c("choroplethr", "choroplethrMaps")) 
library(choroplethr)
library(choroplethrMaps)

load("alcohol.Rdata")
#source("helpers.R")
#counties <- readRDS("data/counties.rds") #Commented out until I try map thing again
#loading me data
acs2014 <- readRDS("data/ACS2014.Rds")
acs2013 <- readRDS("data/ACS2013.Rds")
acs2012 <- readRDS("data/ACS2012.Rds")
acs2011 <- readRDS("data/ACS2011.Rds")
acs2010 <- readRDS("data/ACS2010.Rds")
acs2009 <- readRDS("data/ACS2009.Rds")
acs2008 <- readRDS("data/ACS2008.Rds")
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
                     "2014" = "2014 Traffic Incidents Weighted by Population Density",
                     "2013" = "2013 Traffic Incidents Weighted by Population Density",
                     "2012" = "2012 Traffic Incidents Weighted by Population Density",
                     "2011" = "2011 Traffic Incidents Weighted by Population Density",
                     "2010" = "2010 Traffic Incidents Weighted by Population Density",
                     "2009" = "2009 Traffic Incidents Weighted by Population Density",
                     "2008" = "2008 Traffic Incidents Weighted by Population Density")
    ggplot(data = data, aes(x=`Name.of.Area`, y=`incdensity`)) + geom_bar(stat="identity") + coord_flip()  + theme_minimal() + labs(list(title= legend, x = "County Name", y= "Incidents per person per square mile" )) 
  })
  
  
  output$mapPlot <- renderPlot({
    yearslider <- as.character(input$year)
    
    macs2008 <- data.frame(acs2008[,2], acs2008[,16])
    macs2009 <- data.frame(acs2009[,2], acs2009[,16])
    macs2010 <- data.frame(acs2010[,2], acs2010[,16])
    macs2011 <- data.frame(acs2011[,2], acs2011[,16])
    macs2012 <- data.frame(acs2012[,2], acs2012[,16])
    macs2013 <- data.frame(acs2013[,2], acs2013[,16])
    macs2014 <- data.frame(acs2014[,2], acs2014[,16])
    
    colnames(macs2008) <- c("region", "value")
    colnames(macs2009) <- c("region", "value")
    colnames(macs2010) <- c("region", "value")
    colnames(macs2011) <- c("region", "value")
    colnames(macs2012) <- c("region", "value")
    colnames(macs2013) <- c("region", "value")
    colnames(macs2014) <- c("region", "value")
    
    macs2008[] <- lapply(macs2008, function(x) type.convert(as.character(x)))
    macs2009[] <- lapply(macs2009, function(x) type.convert(as.character(x)))
    macs2010[] <- lapply(macs2010, function(x) type.convert(as.character(x)))
    macs2011[] <- lapply(macs2011, function(x) type.convert(as.character(x)))
    macs2012[] <- lapply(macs2012, function(x) type.convert(as.character(x)))
    macs2013[] <- lapply(macs2013, function(x) type.convert(as.character(x)))
    macs2014[] <- lapply(macs2014, function(x) type.convert(as.character(x)))
    
    macs2008<- aggregate(. ~ region, macs2008, sum)
    macs2009<- aggregate(. ~ region, macs2009, sum)
    macs2010<- aggregate(. ~ region, macs2010, sum)
    macs2011<- aggregate(. ~ region, macs2011, sum)
    macs2012<- aggregate(. ~ region, macs2012, sum)
    macs2013<- aggregate(. ~ region, macs2013, sum)
    macs2014<- aggregate(. ~ region, macs2014, sum)


    data <- switch(yearslider,
                   "2014" = macs2014, #$`Population Density (per sq. mile) ` ,
                   "2013" = macs2013, #$`Population Density (per sq. mile) ` ,
                   "2012" = macs2012, #$`Population Density (per sq. mile) ` ,
                   "2011" = macs2011, #$`Population Density (per sq. mile) ` ,
                   "2010" = macs2010, #$`Population Density (per sq. mile) ` ,
                   "2009" = macs2009, #$`Population Density (per sq. mile) ` ,
                   "2008" = macs2008) #$`Population Density (per sq. mile) ` ),




    legend <- switch(yearslider,
                     "2014" = "2014 Traffic Incidents",
                     "2013" = "2013 Traffic Incidents",
                     "2012" = "2012 Traffic Incidents",
                     "2011" = "2011 Traffic Incidents",
                     "2010" = "2010 Traffic Incidents",
                     "2009" = "2009 Traffic Incidents",
                     "2008" = "2008 Traffic Incidents")
    
    county_choropleth(data, state_zoom=c("new jersey")) + theme_minimal() + labs(list(title= legend, x = "County Name", y= "# of Accidents by location" )) 
    # ggplot(data = data, aes(x=`Name.of.Area`, y=`incdensity`)) + geom_bar(stat="identity") + coord_flip()  + theme_minimal() + labs(list(title= legend, x = "County Name", y= "Incidents per person per square mile" )) 
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


