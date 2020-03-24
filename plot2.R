library(data.table)
library(tidyverse)

electric_power <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Change date and time format
electric_power$Date <- as.Date(electric_power$Date, format="%d/%m/%Y")
electric_power$Time <- strptime(electric_power$Time, format="%H:%M:%S")

electric_power <- electric_power %>%
    filter(Date >= "2007-02-01" & Date <= "2007-02-02")

electric_power <- electric_power %>%
    mutate(DateTime = as.POSIXct(paste(Date, Time, sep=" "), "%d/%m/%Y %H:%M:%S"))

# Create plot in png file

png("plot2.png", width=480, height=480)

plot(x = electric_power[, "DateTime"],
     y = electric_power[, "Global_active_power"],
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

dev.off()

