filename <- "data.zip"

# Check if we;ve downloaded the file
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename, method="curl")
}

# Check if we've unzipped the file
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}

# Read data from file
data <- read.csv("household_power_consumption.txt", header=T, sep=';',  na.strings="?")

# Specify the Date format
data$Date <- as.Date(data$Date,"%d/%m/%Y")
# Subset the Data, obtaining records only for the needed dates
data <- subset(data, (Date >= "2007-02-01" & Date<="2007-02-02"))

# Build histogram and save to the file
x<-as.numeric(data$Global_active_power)
png(filename="plot1.png",width = 480, height = 480)
hist(x, col="red", main="Global Active Power", xlab="Global Active power (kilowatts)", ylab="Frequency")
dev.off()