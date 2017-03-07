ptm <- proc.time()
require(stringr)
require(utils)
require(data.table)
require(dplyr)
#require(readr)
<<<<<<< HEAD
for (yr in 2014:2014)
=======


sapply (2001:2014,
        function (x) {
          AccidentZipFile = paste0("NewJersey",x,"Accidents.zip")
          if (!file.exists(AccidentZipFile)) {
            download.file (url = paste0("http://www.state.nj.us/transportation/refdata/accident/", x, "/NewJersey",x, "Accidents.zip"),
                           destfile = AccidentZipFile)
          }
          if (!file.exists(sub(".zip",".txt",AccidentZipFile))) {
            unzip(AccidentZipFile)
          }
          DriverZipFile = paste0("NewJersey",x,"Drivers.zip")
          if (!file.exists(paste0(DriverZipFile))) {
            download.file (url = paste0("http://www.state.nj.us/transportation/refdata/accident/", x, "/NewJersey",x, "Drivers.zip"),
                           destfile = DriverZipFile)
          }
          if (!file.exists(sub(".zip",".txt",DriverZipFile))) {
            unzip(DriverZipFile)
          }
        }
)


for (yr in 2001:2014)
>>>>>>> origin/master
{
  
print(paste("Begin processing files for year", yr))
  
AccYrFile = paste0("*",yr,"Accidents.txt")
filename <-list.files(pattern=AccYrFile )
accident <-  read.csv(filename,header=FALSE,sep=",", quote="")
colnames(accident) <- c("Case.Number","County.Name","Municipality.Name", 
                            "Crash.Date","Crash.Day.Of.Week","Crash.Time", 
                            "Police.Dept.Code", "Police.Department", 
                            "Police.Station", "Total.Killed", "Total.Injured", 
                            "Pedestrians.Killed", "Pedestrians.Injured", 
                            "Severity", "Intersection", "Alcohol.Involved",
                            "HazMat.Involved", "Crash.Tyep.Code", 
                            "Total.Vehicles.Involve", "Crash.Location", 
                            "Location.Direction", "Route", "Route.Suffix", 
                            "SRI", "MilePost", "Road.System", "Road.Character", 
                            "Road.Surface.Type", "Surface.Condition", 
                            "Light.Condition", "Environmental.Condition",
                            "Road.Divided.By", "Temporary.Traffic.Control.Zone",
                            "Distance.To.Cross.Street", "Unit.Of.Measurement", 
                            "Directn.From.Cross.Street", "Cross.Street.Name", 
                            "Is.Ramp", "Ramp.To.From.Route.Name", 
                            "Ramp.To.From.Route.Direction", "Posted.Speed",
                            "Posted.Speed.Cross.Street", "Latitude", "Longitude",
                            "Cell.Phone.In.Use.Flag", "Other.Property.Damage", 
                            "Reporting.Badge.No")
accident$Crash.Time <- sprintf("%04d",accident$Crash.Time)
accident$Crash.Time <- format(strptime(accident$Crash.Time, format="%H%M"), format = "%H:%M")


print(paste0("*",yr," Accidents file extracted and cleaned"))


AccYrFile = paste0("*",yr,"Drivers.txt")
filename <-list.files(pattern=AccYrFile )
drivers <- read.csv(filename,header=FALSE,sep=",",quote="")

colnames(drivers) <-c("Case.Number",
    "Vehicle.Number",
    "Driver.City",
    "Driver.State",
    "Driver.Zip.Code",
    "Driver.License.State",
    "Driver.DOB",
    "Driver.Sex",
    "Alcohol.Test.Given",
    "Alcohol.Test.Type",
    "Alcohol.Test.Results",
    "Charge",
    "Summons",
    "Multi.Charge.Flag",
    "Driver.Physical.Status")


# drivers$year <- substr(drivers$Case.Number,1,4) %>% as.numeric
# drivers$age = difftime(as.Date(paste0(drivers$year,"-06-30")),drivers$Driver.DOB %>% as.Date(format = "%m/%d/%Y"),units = "weeks")/52.14
drivers$alcohol <- !is.na(drivers$Charge) & grepl("39:4-50|39-4-50|39:4:50|39:4 50|DWI|DUI", drivers$Charge) # Alcohol charge codes? How to determine?


print(paste0("*",yr," Drivers file extracted and cleaned"))

AllData <- merge(drivers,accident,by="Case.Number")
print(paste("Merged accident and driver file for year",yr))


selectCols <- c("Case.Number","County.Name","Municipality.Name", 
                "Crash.Date","Crash.Day.Of.Week","Crash.Time", 
                "Police.Dept.Code", "Police.Department", 
                "Police.Station", "Total.Killed", "Total.Injured", 
                "Pedestrians.Killed", "Pedestrians.Injured", 
                "Severity", "Intersection", "Alcohol.Involved",
                "HazMat.Involved", "Crash.Tyep.Code", 
                "Total.Vehicles.Involve", "Crash.Location", 
              # "Location.Direction",
                "Route", 
              # "Route.Suffix", 
              # "SRI", 
                "MilePost", "Road.System", "Road.Character", 
                "Road.Surface.Type", "Surface.Condition", 
                "Light.Condition", "Environmental.Condition",
                "Road.Divided.By", "Temporary.Traffic.Control.Zone",
                "Distance.To.Cross.Street", "Unit.Of.Measurement", 
                "Directn.From.Cross.Street", "Cross.Street.Name", 
              # "Is.Ramp", 
              # "Ramp.To.From.Route.Name", 
              # "Ramp.To.From.Route.Direction", "Posted.Speed",
                "Posted.Speed.Cross.Street", "Latitude", "Longitude",
                "Cell.Phone.In.Use.Flag", "Other.Property.Damage", 
                "Reporting.Badge.No",    
                "Vehicle.Number",
                "Driver.City",
                "Driver.State",
                "Driver.Zip.Code",
                "Driver.License.State",
                "Driver.DOB",
                "Driver.Sex",
                "Alcohol.Test.Given",
                "Alcohol.Test.Type",
                "Alcohol.Test.Results",
                "Charge",
             #  "Summons",
             #  "Multi.Charge.Flag",
                "Driver.Physical.Status")

# selectCols <- c("Case.Number","Driver.Zip.Code","age","Driver.Sex","alcohol",
#                 "County.Name","Municipality.Name",
#                 "Crash.Date","Crash.Day.Of.Week","Crash.Time",
#                 "Road.Surface.Type", "Surface.Condition",
#                 "Light.Condition", "Environmental.Condition",
#                 "Road.Divided.By", "Temporary.Traffic.Control.Zone",
#                 "Distance.To.Cross.Street", "Unit.Of.Measurement",
#                 "Posted.Speed.Cross.Street", "Latitude", "Longitude",
#                 "Cell.Phone.In.Use.Flag")

col.num <- which(colnames(AllData) %in% selectCols)
FilteredData <- select(AllData,col.num)
save (FilteredData, file ="C:\\Users\\Fireseraph\\Desktop\\Work Bench\\Github\\uncrash\\uncrash\\FilteredData.Rdata")
outFile = paste0("FilteredData",yr,".csv")
write.csv(FilteredData, file = outFile)
print(paste("Generated",outFile, "file"))

outFile = paste0("FilteredData",yr,".Rda")
save (FilteredData, file = outFile)
print(paste("Generated",outFile, "file"))

outFile = paste0("FilteredData",yr,".Rds")
save (FilteredData, file = outFile)
print(paste("Generated",outFile, "file"))


}
proc.time()-ptm