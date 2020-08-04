## EXPLORATORY DATA ANALYSIS

## Plot 3

# Pre-processing functions
# Set working directory
SetworkingDirectory <- function(path = getwd()){
        
        # Get working directory path and set a coursera folder
        folder <<- (paste0(path,"/desktop/coursera"))
        if(!dir.exists(folder)){dir.create(folder)}
        setwd(folder)
        return(folder)
        paste("Working directory folder where files will be written: ", folder)
        
}
# Get files from repository, save and unpack it into working directory
LoadFiles <- function(folder = getwd()){
        
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, file.path(folder, "Dataset.zip"))
        unzip(zipfile = "Dataset.zip")
        print(paste("Download completed! Files save in ->",folder,"<-folder." ))
        
}

SetworkingDirectory()
LoadFiles()



##Processing
#Build dataframe
myData <- read.table('./household_power_consumption.txt', sep = ';', header = TRUE, stringsAsFactors = FALSE)

#Slice subset from dataframe
myData <- myData[myData$Date %in% c("1/2/2007","2/2/2007") ,]

#Convert columns to numeric
myData$Global_active_power <- as.numeric(myData$Global_active_power)
myData$GlobalActivePower <- as.numeric(myData$Global_active_power)
myData$GlobalReactivePower <- as.numeric(myData$Global_reactive_power)
myData$Voltage <- as.numeric(myData$Voltage)
myData$Sub_metering_1 <- as.numeric(myData$Sub_metering_1)
myData$Sub_metering_2 <- as.numeric(myData$Sub_metering_2)
myData$Sub_metering_3 <- as.numeric(myData$Sub_metering_3)

#Create datetime from 'Date'and 'Time' columns
myData$Datetime <- strptime(paste(myData$Date, myData$Time), "%d/%m/%Y %H:%M:%S")

# Build plot
png(filename = "./plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(2,2), mar = c(3,5,2,2))
#Chart 1
plot(myData$Datetime, myData$GlobalActivePower, type="l", ylab="Global Active Power")
#Chart 2
plot(myData$Datetime, myData$Voltage, type="l", ylab="Voltage")
#Chart 3
plot(myData$Datetime, myData$Sub_metering_1, col='blue', type="l", ylab="Energy Submetering")
lines(myData$Datetime, myData$Sub_metering_2, type="l", col="red")
lines(myData$Datetime, myData$Sub_metering_3, type="l", col="green")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=4, seg.len=.5, col=c("blue", "red", "green"), bg = "transparent", box.col = "transparent")
#Chart 4
plot(myData$Datetime, myData$GlobalReactivePower, type="l", ylab="Global Reactive Power")

dev.off()

