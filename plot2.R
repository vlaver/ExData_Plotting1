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
date.time <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(date.time)

# Build the plot and save to the file
x<-as.numeric(data$Global_active_power)
png(filename="plot2.png",width = 480, height = 480)
plot(x~data$Datetime, col="black", type="l", main="", xlab="", ylab="Global Active power (kilowatts)")
dev.off()