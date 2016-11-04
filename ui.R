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

library(shinydashboard)

library(shinyjs)

inputUserid <- function(inputId, value='') {
  #   print(paste(inputId, "=", value))
  tagList(
    singleton(tags$head(tags$script(src = "js/md5.js", type='text/javascript'))),
    singleton(tags$head(tags$script(src = "js/shinyBindings.js", type='text/javascript'))),
    tags$body(onload="setvalues()"),
    tags$input(id = inputId, class = "userid", value=as.character(value), type="text", style="display:none;")
  )
}

inputIp <- function(inputId, value=''){
  tagList(
    singleton(tags$head(tags$script(src = "js/md5.js", type='text/javascript'))),
    singleton(tags$head(tags$script(src = "js/shinyBindings.js", type='text/javascript'))),
    tags$body(onload="setvalues()"),
    tags$input(id = inputId, class = "ipaddr", value=as.character(value), type="text", style="display:none;")
  )
}



dashboardPage(
  
  # tags$main-header(
  #   tags$link(rel = "stylesheet", type = "text/css", href = "NJcrash.css"),
  #   tags$link(rel = "stylesheet", type = "text/css", href = "icon/css/font-awesome.min.css"),
  #   tags$link(rel = "stylesheet", type = "text/css", href = "https://file.myfontastic.com/M27ntRiDvYmgVMSDV8e5Qj/icons.css")
  # ),
  
  skin="yellow",
  #This is the header of the dashboard
  dashboardHeader(

    # title = list(icon("dashboard"),"NJ Crash Overview"),
    title=tags$a(href="http://codeforprinceton.org/",tags$i(class="icon-codeforprinceton-3", style="font-size:50px;",   onMouseOver="this.style.color='rgb(34, 45, 50)'",
                 onMouseOut="this.style.color='rgb(255, 255, 255)'")),
                  # Dynamic Message
                  # dropdownMenuOutput("messageMenu"),
                  
                  #Disable Header Bar
                  disable = F,
  
                  # THis is the dropdown menu
                  dropdownMenu(
                               icon = icon("users"),
                               type = "message",
                               messageItem(
                                 icon=icon("user"),
                                 from = "Jiahuan KANG",
                                 message = " "
                               ),
                               messageItem(
                                 icon=icon("user"),
                                 from = "Manbir Mohindru",
                                 message = " "
                               ),
                               messageItem(
                                   icon=icon("user"),
                                   from = "CHris Hefele",
                                   message = "New member"
                               ),
                               messageItem(
                                 icon=icon("user"),
                                 from = "Paz Tarrio",
                                 message = "New member"
                               ),
                               messageItem(
                                 icon=icon("user"),
                                 from = "Deva Prasad",
                                 message = "New member"
                               ),
                               messageItem(
                                 icon=icon("user"),
                                 from = "Vijay Appasamy",
                                 message = "New member"
                               ),
                               messageItem(
                                 icon=icon("user"),
                                 from = "Ashok Khandelwhl",
                                 message = "New member"
                               ),
                               messageItem(
                                 icon=icon("user"),
                                 from = "Fred Kelly",
                                 message = "New member"
                               )
                          ),
                  dropdownMenu(
                    icon = icon("tasks"),
                    type = "tasks",
                    taskItem(
                      "Create UI",
                      value=10,
                      color="green"
                      # href = ""
                    ),
                    taskItem(
                      "Fix data issues",
                      value=50,
                      color="aqua"
                      # href = ""
                    ),
                    taskItem(
                      "Create basic statistics",
                      value=20,
                      color="yellow"
                      # href = ""
                    ),
                    taskItem(
                      "Create data visulizations",
                      value=30,
                      color="aqua"
                      # href = ""
                    ),
                    taskItem(
                      "Write up stories for data and visualizations",
                      value=35,
                      color="red"
                      # href = ""
                    )
                  )
                  
                  
                  # dropdownMenu(
                  #   icon = icon("tasks"),
                  #   type = "notification",
                  #   notificationItem("text", icon = shiny::icon("warning"), status = "success",
                  #                    href = NULL)
                  # 
                  # )

                  
             ),
  
  
  # This is the side bar of the dashboard
  dashboardSidebar(
    # disable=TRUE,
    # sideBarMini=TRUE,
    
    # 
    # useShinyjs(),
    # actionButton("showSidebar", "Show sidebar"),
    # actionButton("hideSidebar", "Hide sidebar"),
    
    #Counter
    inputIp("ipid"),
    inputUserid("fingerprint"),
    
    
    #search form server side code: input$searchText and input$searchButton
    sidebarSearchForm("searchText", "searchButton", label = "Search...",
                      icon = shiny::icon("search")),
    
    
    
    sidebarMenu(id="sidebarMenu",
      
      menuItem("Control Panel",tabName = "Dashboard",icon = icon("dashboard"),fluidRow(width=12,
        sliderInput("year", label = "Select Year:",min = 2001, max = 2014, value = 2001, sep="", ticks=TRUE, animate=TRUE)
        # hr(),
        # selectInput("trendtype", label = "What are you interested in?", 
        #             choices = list("NJ Accidents by Gender" = 1, "NJ Accidents by Day of Week" = 2, "NJ Accidents by ..." = 3), 
        #             selected = 1)
      )),
      menuItem("Home",tabName = "Home",icon = icon("home")),
      
      menuItem("Basic Statistics",tabName = "Basic_Statistics",icon = icon("info-circle")),
      
      menuItem("Accidents", tabName = "accidents", icon=icon("th"),badgeLabel = "updating", badgeColor = "green"),
      menuItem("Driver", tabName = "driver", icon=icon("th"),badgeLabel = "updating", badgeColor = "green"),
      menuItem("Code for Princeton",icon=icon("th"),href="http://codeforprinceton.org/",newtab =F),
      menuItem("Github",icon=icon("th"),href="https://github.com/codeforprinceton/uncrash",newtab = F)
    ),
    conditionalPanel("input.sidebarMenu == 'Home'",
                     class = "shiny-input-container",
                     sliderInput("graph_slider", "Graphs slider:", min=1, max=10, value=2)
    ),
    conditionalPanel("input.sidebarMenu == 'accidents'",
                     class = "shiny-input-container",
                     sliderInput("table_slider", "Table slider:",  min=1, max=10, value=3)
    )
  ),
  
  
  
  
  
  # This is the body of Dashboard
  dashboardBody(
    useShinyjs(),
 
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "NJcrash.css"),
      tags$link(rel = "stylesheet", type = "text/css", href = "icon/css/font-awesome.min.css"),
      tags$link(rel = "stylesheet", type = "text/css", href = "https://file.myfontastic.com/M27ntRiDvYmgVMSDV8e5Qj/icons.css")
    ),
    
  tabItems(
    #tab 0
    tabItem(tabName="select"    ),

    #tab 1
    tabItem(tabName="Home",
       
     fluidRow(style="margin-top:50px;",
       box(width=12, collapsible = TRUE, title = list(icon("dashboard"),"NJ Crash Overview"),

              tabBox(
                id="tabset1",
                width = "100%",
              tabPanel("NJ Accident by Gender",collapsible=TRUE,solidHeader=TRUE,status="warning",
                       # fluidRow(width=3, selectInput("trendtype", label = "What are you interested in?", 
                       #                                   choices = list("NJ Accidents by Gender" = 1, "NJ Accidents by Day of Week" = 2, "NJ Accidents by ..." = 3), 
                       #                                   selected = 1)),
                       # 
                       plotlyOutput("trendline", width = "100%", height = "100%"),width="1280px",height="500px")
              ,
              tabPanel("NJ Accident by Day of Week",collapsible=TRUE,solidHeader=TRUE,status="warning",plotlyOutput("trendline2", width = "100%", height = "100%"),width="1280px",height="500px")
              ,
              #tabPanel("Pie chart",collapsible=TRUE,solidHeader=TRUE,status="warning",plotlyOutput("pie", width = "auto", height = "500px"),width="1280px",height="500px"),
              tabPanel("Bar chart",collapsible=TRUE,solidHeader=TRUE,status="warning",plotlyOutput("bar", width = "100%", height = "100%"),width="1280px",height="500px")
              )
              )),
     fluidRow(
       box(width=12,status = "warning",  title=list(tags$i(class="fa fa-grav"),"What we discovered?"),collapsible = TRUE,
          hr(), 
          h4("From year 2001 till 2014, 9,058 people were killed and 1,386,636 people were injured in 4,062,688 car accidents in the state of NJ,
              that is, on average, 647 people killed and 99,045 people injured every year on NJ roads. 
              "),
           p("The Uncrash team took a look to the traffic accidents in NJ from 2001 to 2014. 
             The data was analyzed in different ways to look for patterns that would help us to reach conclusions that eventually would lead to raise awareness about the factors more frequently associated with traffic crashes to avoid/be mindful of those and hopefully diminish the incidence of car crashes.
             
             The data analyzed identified geographical points with higher incidence of crashes. Those point coincide most of the times with street intersections.
             
             Males are more frequently involved in car crashes than females.
             
             Younger population are more frequently involved in car crashes involving only one car
             
             The team propose different ways to visualize these data and different approaches to look at the data from statewide information to street-wide information
             "),
           tags$li("1-    Big areas - Heatmaps showing areas of high accident frequency"),
           tags$li("2-    Accident density map focusing on Route 1. It is the largest contribute to accidents in our local area."),
           tags$li("3-    Street level maps showing precise locations of high incidence of crushes (i.e. clusters)")
           ,p("Between 2001 and 2014, the traffic crash that involved a higher number of cars in NJ was on Monmouth County, on August 27, 2003.")
           ) 
     )
 ,
     fluidRow(
         column(6, box(width=12,status = "success",collapsible = TRUE,collapsed = F,
            plotlyOutput("pie", width = "auto", height = "auto"),
            box(width = 12, status = "warning",
                h4("County Accident"),
                p("Accidents by County charts shows the porportion of accidents in NJ by County. 
                Of all the counties in NJ, Essex, Bergen, Middlesex county have the most accidents, which accounts to 1/3 of all accidents in NJ")
            )
          ),
          
          box(width = 12, status = "primary",
              img(src="heatmap.png"),
              box(width = 12, status = "warning",
                  h4("Accident Heat Map"),
                  p("This plot is a heatmap showing accident \"hot-spots\" 
                in the Princeton & West Windsor areas from 2001-2014. 
                US Route 1 (the long diagonal line near the
                center of the image) and downtown Princeton 
                (the red cluster at the top of the map)
                are the largest contributors to local accidents.
                Local and residential streets are not.")
                  
              )
          )
         ),
 
 column(6,
 box(width = 6, status = "primary",collapsible = TRUE,collapsed = F,
     img(src="US1.png"),
     box(width = 12, status = "warning",
         h4("US Route 1 Chart"),
         p("This plot shows the accident density on US Route 1
             in the Princeton, NJ area (as derived from 
             NJ DOT accident data 2001-2014). 
             The major cross-streets are shown on the bottom;
             the correspondence of the peaks with the cross streets
             shows that most accidents occur at major intersections, 
             not *between* intersections.")
     )
 ),
 
 box(width = 6, status = "success",
     img(src="NJ_Accdt.png"),
     box(width = 12, status = "warning",
         h4("Accidents in NJ"),
         p("Each of the 7,000+ dots on this map represents a NJ 
accident with a fatality during the 
                the pariod 2001-2014,  The main highways
                can be seen in the pattern of dots, 
                such as Routes 80 & Route 78 near the top of the plot, 
                the Garden State Parkway near the right, 
                Route 1 and the NJ Turnpike near the middle, and 
                the Atlantic City Expressway near the bottom.
                ")
         
     )
 )
 )
 

        
         ),
        
        # fluidRow(
          
          
          

 # ),
        
        # Add Approval box
        fluidRow(
          column(11," "),
          column(1,
          valueBoxOutput("approvalBox", width="5%"),
          actionButton("count","Click")
          # h5(textOutput("counter"))
          # textOutput("testtext")
          )
        )
        
        
    ),
 
 # tab 2
 tabItem(tabName="Basic_Statistics",
         
         h3("Basic Information and Statistics about NJ Crash Data", align="center"),
         
         tags$hr(),
         
         
         box(DT::dataTableOutput('tbl'),
             status="warning",
             title="Data field names and type ",
             width=6,
             collapsible=TRUE
             )
         
 ),
    
    #tab 3
    tabItem(tabName="accidents",
            h4("Accidents in Princeton Intersections"),
            p("This street-level maps show the exact locations
of accidents in the Princeton/West-Windsor area
between 2001 and 2014.  Each accident is represented
with a dot. If there were multiple accidents
at a specific location, the dots are aggregated
and the count shown within a larger circle. 
When looking at this street-level detail, it's
clear that intersections along major roads 
are the most frequent location for accdeints."),
            
            fluidRow(
              htmlOutput("frame")
            )
    ),
    
    # tab 4
    tabItem(tabName="driver",
            h2("Widgets tab content")
       
         )
    
    # # tab 4
    # tabItem(tabName="Code for Princeton",
    #         h2("Widgets tab content")
    #         
    # ),
    # 
    # # tab 5
    # tabItem(tabName="Github",
    #         h2("Widgets tab content")
    #         
    # )
     )
  )
)









# sidebarLayout(
#   sliderInput("year", label = h4("Select year:"),
#               min = 2001, max = 2014, value = 2001, sep="", ticks=FALSE, animate=TRUE),
#   
#   plotlyOutput("trendline", width = "100%", height = 900)
# )
# 
# )) 
  
  

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


