# This script downloads NJ driver accidents from 2001 to 2014, lables the column headings appropriate

# download and unzip driver data
require(utils)
require(data.table)
require(dplyr)
sapply (2001:2014,
        function (x) {
          download.file (url = paste0("http://www.state.nj.us/transportation/refdata/accident/", x, "/NewJersey",x, "Accidents.zip"),
                         destfile = paste0(x,".zip"))
        }
)
sapply(list.files(pattern = "*.zip"),unzip)
sapply(list.files(pattern = "*.zip"), file.remove)

drivers <- do.call(rbind, lapply(list.files(pattern = "*.txt"), fread))

# add columns and clean up

colnames(Accidentfile) <- c("Year.County.Municipality.Case.Number","County.Name","Municipality.Name", "Crash.Date","Crash.Day.Of.Week","Crash.Time", "Police.Dept.Code", "Police.Department", "Police.Station", "Total.Killed", "Total.Injured", "Pedestrians.Killed", "Pedestrians.Injured", "Severity", "Intersection", "Alcohol.Involved","HazMat.Involved", "Crash.Tyep.Code", "Total.Vehicles.Involve", "Crash.Location", "Location.Direction", "Route", "Route.Suffix", "SRI", "MilePost", "Road.System", "Road.Character", "Road.Surface.Type", "Surface.Condition", "Light.Condition", "Environmental.Condition","Road.Divided.By", "Temporary.Traffic.Control.Zone", "Distance.To.Cross.Street", "Unit.Of.Measurement", "Directn.From.Cross.Street", "Cross.Street.Name", "Is.Ramp", "Ramp.To.From.Route.Name", "Ramp.To.From.Route.Direction", "Posted.Speed", "Posted.Speed.Cross.Street", "Latitude", "Logitude", "Cell.Phone.In.Use.Flag", "Other.Property.Damage", "Reporting.Badge.No"  )