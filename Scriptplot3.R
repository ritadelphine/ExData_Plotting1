#Zip file downloaded and stored in project folder.
#Data extraction from zip file

library(lubridate)
library(dplyr)

EDHfile <- "exdata_data_household_power_consumption.zip"
unzip(EDHfile)
EDH <- read.table("household_power_consumption.txt", header=TRUE, na.strings = "?", sep=";")

#Converting all variables to dates and times using strptime and lubridate. New variable made for datetime combined.
EDH$DT <- paste(EDH$Date, EDH$Time, sep=" ")
EDH$datetime <- strptime(EDH$DT, "%d/%m/%Y %H:%M:%S")
EDH$Date <- dmy(EDH$Date)
EDH$Time <- strptime(EDH$Time, format = "%H:%M:%S")
EDH$Time <- format(EDH$Time, "%H:%M:%S")

EDHsubset <- subset(EDH, EDH$Date >= as.Date("2007-02-01") & EDH$Date < as.Date("2007-02-03"))

#line scatter plot with 3 submeters (plot3)
png("plot3.png", width=480, height=480)
with(EDHsubset, plot(datetime, Sub_metering_1, type = "l", col="black", xlab="", ylab="Energy Sub metering"))
with(EDHsubset, lines(datetime, Sub_metering_2, type="l", col="red"))
with(EDHsubset, lines(datetime, Sub_metering_3, type= "l", col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()