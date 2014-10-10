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
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# set the 2 by 2 matrix for the plots
par(mfrow = c(2, 2) )

# Top Left
plot(dat$DateTime, dat$Global_active_power, type="l", ylab="Global Active Power", xlab="")

# Top right
plot(dat$DateTime, dat$Voltage, type="l", ylab="Voltage", xlab="datetime")

# Bottom left
{
plot(dat$DateTime, dat$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(dat$DateTime, dat$Sub_metering_2, col="red")
lines(dat$DateTime, dat$Sub_metering_3, col="blue")
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), 
      lwd=1, bty="n")
}

# Bottom right
plot(dat$DateTime, dat$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")

#close device
dev.off()