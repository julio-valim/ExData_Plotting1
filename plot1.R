## EXPLORATORY DATA ANALYSIS

## Plot 1

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

#Convert 'Global_active_power' column to numeric
myData$Global_active_power <- as.numeric(myData$Global_active_power)

# Build histogram plot
png(filename = "./plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow = c(1,1), mar = c(7,7,5,3))
hist(myData$Global_active_power, col = 'red', xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
