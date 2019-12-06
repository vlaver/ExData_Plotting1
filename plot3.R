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
png(filename="plot3.png",width = 480, height = 480)
plot(data$Sub_metering_1~data$Datetime, col="black", type="n", main="", xlab="", ylab="Energy sub metering")
lines(data$Sub_metering_1 ~ data$Datetime, col = "black")
lines(data$Sub_metering_2 ~ data$Datetime, col = "red")
lines(data$Sub_metering_3 ~ data$Datetime, col = "blue")
legend("topright", lty=1, lwd =3, col=c("black","red","blue") ,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()