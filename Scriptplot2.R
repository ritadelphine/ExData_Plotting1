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

#line scatter plot (plot2)
png("plot2.png", width=480, height=480)
with(EDHsubset, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()