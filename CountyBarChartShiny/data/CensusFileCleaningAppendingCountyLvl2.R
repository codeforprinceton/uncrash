setwd("~/Desktop/hackathon/uncrashgithub/CountyBarChartShiny/data") #Wylie's Directory
rm(list = ls())
library(magrittr)
#invisible(readline(prompt="Press [enter] to continue"))
#LOADING DATA (not using loops because i'm too lazy to learn that right now)
ACS.1.Year.2014.All.Counties <- read.csv("ACS 1-Year 2014 All Counties.csv", header=TRUE)
ACS.1.Year.2013.All.Counties <- read.csv("ACS 1-Year 2013 All Counties.csv", header=TRUE)
ACS.1.Year.2012.All.Counties <- read.csv("ACS 1-Year 2012 All Counties.csv", header=TRUE)
ACS.1.Year.2011.All.Counties <- read.csv("ACS 1-Year 2011 All Counties.csv", header=TRUE)
ACS.1.Year.2010.All.Counties <- read.csv("ACS 1-Year 2010 All Counties.csv", header=TRUE)
ACS.1.Year.2009.All.Counties <- read.csv("ACS 1-Year 2009 All Counties.csv", header=TRUE)
ACS.1.Year.2008.All.Counties <- read.csv("ACS 1-Year 2008 All Counties.csv", header=TRUE)
#DROPPING EXTRA HEADER ROW FROM EACH TABLE
ACS.1.Year.2014.All.Counties <- ACS.1.Year.2014.All.Counties[-1,]
ACS.1.Year.2013.All.Counties <- ACS.1.Year.2013.All.Counties[-1,]
ACS.1.Year.2012.All.Counties <- ACS.1.Year.2012.All.Counties[-1,]
ACS.1.Year.2011.All.Counties <- ACS.1.Year.2011.All.Counties[-1,]
ACS.1.Year.2010.All.Counties <- ACS.1.Year.2010.All.Counties[-1,]
ACS.1.Year.2009.All.Counties <- ACS.1.Year.2009.All.Counties[-1,]
ACS.1.Year.2008.All.Counties <- ACS.1.Year.2008.All.Counties[-1,]
#ADDING IN YEARS TO EACH TABLE
ACS.1.Year.2014.All.Counties$year <- "2014"
ACS.1.Year.2013.All.Counties$year <- "2013"
ACS.1.Year.2012.All.Counties$year <- "2012"
ACS.1.Year.2011.All.Counties$year <- "2011"
ACS.1.Year.2010.All.Counties$year <- "2010"
ACS.1.Year.2009.All.Counties$year <- "2009"
ACS.1.Year.2008.All.Counties$year <- "2008"
#SETTING WHAT VARIABLES TO KEEP
varstokeep <- c("FIPS","year","Name.of.Area","Qualifying.Name","State.U.S..Abbreviation..USPS.","Summary.Level","County","Geographic.Identifier","Area..Land.","Area..Water.","Total.Population","Population.Density..per.sq..mile.")
acs2008<- ACS.1.Year.2008.All.Counties[varstokeep]
acs2009<- ACS.1.Year.2009.All.Counties[varstokeep]
acs2010<- ACS.1.Year.2010.All.Counties[varstokeep]
acs2011<- ACS.1.Year.2011.All.Counties[varstokeep]
acs2012<- ACS.1.Year.2012.All.Counties[varstokeep]
acs2013<- ACS.1.Year.2013.All.Counties[varstokeep]
acs2014<- ACS.1.Year.2014.All.Counties[varstokeep]
#FIXING THE COUNTY NAMES - I GIVE UP ON THIS, did it in Excel, don't tell
# acs2008 %>%
#   substr(`Name.of.Area`,regexpr(' ',`Name.of.Area`)) %>%
#   acs2008
#MERGING IN THE TRAFFIC INCIDENT DATA
incid <- read.csv("county_data_pivot.csv", header=TRUE)

#try 1
#acs2008<- merge(acs2008, incid, by = c("Name of Area","year"))
#^^getting error: "Error in fix.by(by.x, x) : 'by' must specify a uniquely valid column" -- but it does!!

#try 2
#acs2008<- merge(acs2008, incid, by.x = c("Name of Area","year"), by.y = c("Name of Area","year"))
#^^still no love

#try 3 - going to create a new key value for all the tables by concatenating
incid$key <- paste(incid$Name.of.Area, incid$year, sep = "_")
acs2008$key <-paste(acs2008$Name.of.Area, acs2008$year, sep = "_")
acs2009$key <-paste(acs2009$Name.of.Area, acs2009$year, sep = "_")
acs2010$key <-paste(acs2010$Name.of.Area, acs2010$year, sep = "_")
acs2011$key <-paste(acs2011$Name.of.Area, acs2011$year, sep = "_")
acs2012$key <-paste(acs2012$Name.of.Area, acs2012$year, sep = "_")
acs2013$key <-paste(acs2013$Name.of.Area, acs2013$year, sep = "_")
acs2014$key <-paste(acs2014$Name.of.Area, acs2014$year, sep = "_")
#and now merging on what should be a single unique key field shared by both datasets
acs2008<- merge(acs2008,incid,by = "key" )
acs2009<- merge(acs2009,incid,by = "key" )
acs2010<- merge(acs2010,incid,by = "key" )
acs2011<- merge(acs2011,incid,by = "key" )
acs2012<- merge(acs2012,incid,by = "key" )
acs2013<- merge(acs2013,incid,by = "key" )
acs2014<- merge(acs2014,incid,by = "key" )
#now it's all in each census file, but R has appended on an x and y to each of my key fields.
#re-adding a normal year and Name of Area field
acs2008$year <- acs2008$year.x ; acs2008$Name.of.Area <- acs2008$Name.of.Area.x
acs2009$year <- acs2009$year.x ; acs2009$Name.of.Area <- acs2009$Name.of.Area.x
acs2010$year <- acs2010$year.x ; acs2010$Name.of.Area <- acs2010$Name.of.Area.x
acs2011$year <- acs2011$year.x ; acs2011$Name.of.Area <- acs2011$Name.of.Area.x
acs2012$year <- acs2012$year.x ; acs2012$Name.of.Area <- acs2012$Name.of.Area.x
acs2013$year <- acs2013$year.x ; acs2013$Name.of.Area <- acs2013$Name.of.Area.x
acs2014$year <- acs2014$year.x ; acs2014$Name.of.Area <- acs2014$Name.of.Area.x
#calculating a incidents per person per sq mi figure
acs2008$incdensity <- acs2008$Incidents / as.numeric(as.character(acs2008$Population.Density..per.sq..mile.))
acs2009$incdensity <- acs2009$Incidents / as.numeric(as.character(acs2009$Population.Density..per.sq..mile.))
acs2010$incdensity <- acs2010$Incidents / as.numeric(as.character(acs2010$Population.Density..per.sq..mile.))
acs2011$incdensity <- acs2011$Incidents / as.numeric(as.character(acs2011$Population.Density..per.sq..mile.))
acs2012$incdensity <- acs2012$Incidents / as.numeric(as.character(acs2012$Population.Density..per.sq..mile.))
acs2013$incdensity <- acs2013$Incidents / as.numeric(as.character(acs2013$Population.Density..per.sq..mile.))
acs2014$incdensity <- acs2014$Incidents / as.numeric(as.character(acs2014$Population.Density..per.sq..mile.))
#Sorting things, hopefully
acs2014 <- acs2014[order( - acs2014$incdensity),]
acs2013 <- acs2013[order( - acs2013$incdensity),]
acs2012 <- acs2012[order( - acs2012$incdensity),]
acs2011 <- acs2011[order( - acs2011$incdensity),]
acs2010 <- acs2010[order( - acs2010$incdensity),]
acs2009 <- acs2009[order( - acs2009$incdensity),]
acs2008 <- acs2008[order( - acs2008$incdensity),]
#SAVING INDIVIDUAL YEAR-COUNTY FILES
saveRDS(acs2008, file = "ACS2008.rds")
saveRDS(acs2009, file = "ACS2009.rds")
saveRDS(acs2010, file = "ACS2010.rds")
saveRDS(acs2011, file = "ACS2011.rds")
saveRDS(acs2012, file = "ACS2012.rds")
saveRDS(acs2013, file = "ACS2013.rds")
saveRDS(acs2014, file = "ACS2014.rds")
#APPENDING DATASETS FOR EACH YEAR TOGETHER
#acs0814 <- rbind(acs2014, acs2013, acs2012, acs2011, acs2010, acs2009, acs2008)
#saveRDS(acs0814, file = "ACS0814.rds")
