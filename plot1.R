# require sqldf package
require(sqldf)

# set the working directory which stores the household_power_consumption.txt
setwd("C:/exdata-007")

# download the file if it is not in the directory
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "exdata-data-household_power_consumption.zip"
fname <- "household_power_consumption.txt"

if (!file.exists( fname)) {
   download.file(url, destfile=zipfile, mode = "wb")
   unzip(zipfile)
}

# read in only data between the 2 dates
dat <- read.csv.sql("household_power_consumption.txt", 
	sql = "SELECT * from file WHERE Date in ('1/2/2007', '2/2/2007')", 
	sep = ";", header = TRUE)

# create a new column for DateTime
dat$DateTime <- strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S")

# open png device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# create plot 1
hist(dat$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

# close device
dev.off()