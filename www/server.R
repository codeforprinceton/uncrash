#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(magrittr)
library(plotly)
library(plyr)

library(shiny)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$trendline <- renderPlotly({
    for (yr in 2001:2014){
      load(paste("data/Accbygender",yr,".Rda",sep=""))
      assign(paste("Accbygender",yr,sep=""), Accbygender)
    }
    
    
    
    
    # Accbygender$color[Accbygender$Driver.Sex=="M"] <- "Male"
    # Accbygender$color[Accbygender$Driver.Sex=="F"] <- "Female"
    # Accbygender$color[Accbygender$Driver.Sex==" "] <- "Unknown"
    
    ###Annotations
    
    # m <- get(paste("Accbygender",input$year,sep = ""))[get(paste("Accbygender",input$year,sep = ""))$count>1500  & (get(paste("Accbygender",input$year,sep = ""))$Driver.Sex!="F"),]
    # n <- get(paste("Accbygender",input$year,sep = ""))[(get(paste("Accbygender",input$year,sep = ""))$count>1500) & (get(paste("Accbygender",input$year,sep = ""))$Driver.Sex=="F"),]
    
    m <- get(paste("Accbygender",input$year,sep = ""))[order(get(paste("Accbygender",input$year,sep = ""))$count,decreasing=TRUE)[1:5],]
    
    # m
    
    # rownames(m)
  
    
    a <- list(
      x=m$date,
      y=m$count,
      text=paste(m$count,m$color,"Crashes on", m$date),
      xref="x",
      yref="y",
      showarrow=T,
      arrowhead=3,
      ax=20,
      zy=-40
    )
    
    
   p<-  plot_ly(get(paste("Accbygender",input$year,sep = "")),x=~date, y=~count) %>% 
      add_lines(color=~color,colors=c('Male'="#2b8cbe", 'Female'="#feb24c",'Unknown'="#636363")) %>%
     add_markers(
       hoverinfo = "text",
       text = ~paste(count,color,"Crashes on",date),
       marker=list(line = list(color = "black",width=1), opacity=0.3)
     )%>%
      # add_annotations(
      #   x=n$date,
      #   y=n$count,
      #   text=paste(n$count,n$color,"Crashes on", n$date),
      #   font = list(size = 13, family = "Arial",color="#feb24c"),
      #   xref="x",
      #   yref="y",
      #   showarrow=T,
      #   arrowhead=3,
      #   ax=-20,
      #   ay=40)%>%
      # add_markers(
      #   hoverinfo = "text",
      #   text = ~paste(count,color,"Crashes on",date),
      #   alpha=0.2
      # ) %>%
      layout( title="NJ Accidents by gender from 2001 to 2014", 
              
              #Add annotations
              annotations=a,
              autosize=T,
              width=1680,
              height=600,
              titlefont=list(
                color="grey",
                size=20
              ),
              xaxis = list(
                # title=~paste("Date in Year",input$year),
                nticks=24,
                showgrid=T,
                color="grey",
                showticksuffix="all",
                titlefont=list(
                  color="black",
                  zeroline=T),
                
                rangeselector = list(
                  buttons = list(
                    list(
                      count = 3, 
                      label = "3 mo", 
                      step = "month",
                      stepmode = "backward"),
                    list(
                      count = 6, 
                      label = "6 mo", 
                      step = "month",
                      stepmode = "backward"),
                    list(
                      count = 1, 
                      label = "1 yr", 
                      step = "year",
                      stepmode = "backward"),
                    list(
                      count = 1, 
                      label = "YTD", 
                      step = "year",
                      stepmode = "todate"),
                    list(step = "all")))
                # ,
                # 
                # rangeslider = list(type = "date",
                #                    thickness=0.2,
                #                    autosize=T,
                #                    yanchor="bottom",
                #                    xanchor="center")
                ),
              yaxis=list(title="Number of drivers in accident per day")
      )
      p
  })
  
})
