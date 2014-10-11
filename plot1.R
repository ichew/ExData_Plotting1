#######################
# Dear Peer Reviewer,
# Please note that I have placed the read data codes in each of the R scripts
# because the question specifically said "there should be 4 PNG files and 4 R code files".
# Otherwise, i will have a 5th load_data.R and have each script source from that load_data.R
#######################

#######################
# start of load_data codes
#######################

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

#######################
# end of load_data codes
#######################

#######################
# start of plotting codes
#######################

# open png device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# create plot 1
hist(dat$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

# close device
dev.off()

#######################
# end of plotting codes
#######################
