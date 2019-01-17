#initialize libraries
library(dplyr)
library(data.table)
library(tidyr)

#check for target directory
if(!file.exists("./ExData_Plotting1")) {
  dir.create("./")
}
setwd("C:/Users/roeifredo/Documents/ExData_Plotting1")

#unzip the file
outDir <- "C:/Users/roeifredo/Documents/ExData_Plotting1"
unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip", exdir = outDir)

##read only the rows that describe 1/2/2007 and 2/2/2007
rawdatavar <- names(fread("household_power_consumption.txt", nrows = 1, data.table = FALSE))
rawdata1 <- fread("grep \\b1/2/2007 household_power_consumption.txt", data.table = FALSE)
rawdata2 <- fread("grep \\b2/2/2007 household_power_consumption.txt", data.table = FALSE)
rawdata <- rbind(rawdata1, rawdata2)
names(rawdata) <- rawdatavar
##rawdata$Date <- as.Date(rawdata$Date, "%d/%m/%Y")
##reclass the date and time variables as POSIXlt
rawdata$Full_Date <- with(rawdata, paste(Date, Time))
rawdata$Full_Date <- strptime(rawdata$Full_Date, "%d/%m/%Y %H:%M:%S")
rawdata <- rawdata[, c(10,3,4,5,6,7,8,9)]

png(file = "Plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(rawdata, plot(Full_Date, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
with(rawdata, plot(Full_Date, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with(rawdata, plot(Full_Date, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
lines(rawdata$Full_Date, rawdata$Sub_metering_1)
lines(rawdata$Full_Date, rawdata$Sub_metering_2, col = "red")
lines(rawdata$Full_Date, rawdata$Sub_metering_3, col = "blue")
legend("topright", lwd = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(rawdata, plot(Full_Date, Global_reactive_power, type = "l", xlab = "datetime"))
dev.off()


