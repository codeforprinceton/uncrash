# This script downloads NJ driver accidents and drivers data from 2001 to 2014, labels the column headings appropriate

# download and unzip Accidents data
require(utils)
require(data.table)
require(dplyr)

#sapply (2001:2014,
sapply (2001:2001,
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
{
  AccYrFile = paste0("*",yr,"Accidents.txt")
  print(AccYrFile)
  list.files(pattern=AccYrFile )

    Accidentfile <- do.call(rbind, lapply(list.files(pattern = AccYrFile), fread))

    # add columns and clean up
    # Changed Year.County.Municipality.Case.Number to Case.Number
    colnames(Accidentfile) <- c("Case.Number","County.Name","Municipality.Name", 
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
                    "Reporting.Badge.No"  )
  
    DrvFile = paste0("*",yr,"Drivers.txt")
    print(DrvFile)
    list.files(pattern=DrvFile)
    drivers <- do.call(rbind, lapply(list.files(pattern = DrvFile), fread))

    # add columns and clean up

    drivers$V15 <- NULL
    drivers$V14 <- NULL
    drivers$V2 <- NULL


    colnames(drivers) <-
      c("Case.Number",
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
        "Summons")

    # estimate age

    drivers$year <- substr(drivers$Case.Number,1,4) %>% as.numeric
    drivers$age = difftime(as.Date(paste0(drivers$year,"-06-30")),drivers$Driver.DOB %>% as.Date(format = "%m/%d/%Y"),units = "weeks")/52.14
    drivers$alcohol <- !is.na(drivers$Charge) & grepl("39:4-50|39-4-50|39:4:50|39:4 50|DWI|DUI", drivers$Charge)

    # 
    AllData <- merge(drivers,Accidentfile,by="Case.Number")
    selectCols <- c("Driver.Zip.Code","age","Driver.Sex","alcohol",
            "County.Name","Municipality.Name",
            "Crash.Date","Crash.Day.Of.Week","Crash.Time",
            "Road.Surface.Type", "Surface.Condition", 
            "Light.Condition", "Environmental.Condition",
            "Road.Divided.By", "Temporary.Traffic.Control.Zone",
            "Distance.To.Cross.Street", "Unit.Of.Measurement",
            "Posted.Speed.Cross.Street", "Latitude", "Longitude",
            "Cell.Phone.In.Use.Flag")

    col.num <- which(colnames(AllData) %in% selectCols)
    FilteredData <- select(AllData,col.num)
    #save (FilteredData, file ="c:/users/preiss/datasources/uncrash/FilteredData.Rdata")
    outFile = paste0("FilteredData",yr,".csv")
    write.csv(FilteredData, file = outFile)
    outFile = paste0("FilteredData",yr,".Rda")
    save (FilteredData, file = outFile)
    outFile = paste0("FilteredData",yr,".Rds")
    save (FilteredData, file = outFile)
}
