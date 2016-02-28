# This script downloads NJ driver data from 2001 to 2014, lables the column headings appropriatley, and removes columns that seem to be blank. It also picks out drivers who were charged with a DWI.

# download and unzip driver data
require(utils)
require(data.table)
require(dplyr)
sapply (2001:2014,
        function (x) {
          download.file (url = paste0("http://www.state.nj.us/transportation/refdata/accident/", x, "/NewJersey",x, "Drivers.zip"),
                         destfile = paste0(x,".zip"))
        }
)
sapply(list.files(pattern = "*.zip"),unzip)
sapply(list.files(pattern = "*.zip"), file.remove)

drivers <- do.call(rbind, lapply(list.files(pattern = "*.txt"), fread))

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


alcohol <- 
  drivers %>% 
  group_by(year, alcohol) %>%
  summarise(
          men = sum(Driver.Sex=="M"),
          women = sum(Driver.Sex=="F"),
          age = mean(age, na.rm=T )
          )
save (alcohol, file ="alcohol.Rdata")

