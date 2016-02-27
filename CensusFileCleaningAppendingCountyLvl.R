#setwd(" ")
rm(list = ls())
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
ACS.1.Year.2008.All.Counties<- ACS.1.Year.2008.All.Counties[varstokeep]
ACS.1.Year.2009.All.Counties<- ACS.1.Year.2009.All.Counties[varstokeep]
ACS.1.Year.2010.All.Counties<- ACS.1.Year.2010.All.Counties[varstokeep]
ACS.1.Year.2011.All.Counties<- ACS.1.Year.2011.All.Counties[varstokeep]
ACS.1.Year.2012.All.Counties<- ACS.1.Year.2012.All.Counties[varstokeep]
ACS.1.Year.2013.All.Counties<- ACS.1.Year.2013.All.Counties[varstokeep]
ACS.1.Year.2014.All.Counties<- ACS.1.Year.2014.All.Counties[varstokeep]
#APPENDING DATASETS FOR EACH YEAR TOGETHER
ACS.1.Year.20082014.All.Counties <- rbind(ACS.1.Year.2014.All.Counties, ACS.1.Year.2013.All.Counties, ACS.1.Year.2012.All.Counties, ACS.1.Year.2011.All.Counties, ACS.1.Year.2010.All.Counties, ACS.1.Year.2009.All.Counties, ACS.1.Year.2008.All.Counties)
save(ACS.1.Year.20082014.All.Counties, file = "ACS0815.Rds")
