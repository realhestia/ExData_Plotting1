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

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

plot(x = electric_power[, "DateTime"],
     y = electric_power[, "Global_active_power"],
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")

plot(x = electric_power[, "DateTime"],
     y = electric_power[, "Voltage"],
     type="l",
     xlab="datetime",
     ylab="Voltage")

plot(x = electric_power[, "DateTime"],
     y = electric_power[, "Sub_metering_1"],
     type="l", xlab="", ylab="Energy sub metering")
lines(electric_power[, "DateTime"], electric_power[, "Sub_metering_2"],col="red")
lines(electric_power[, "DateTime"], electric_power[, "Sub_metering_3"], col="blue")
legend("topright", col = c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, bty="n", cex=.5)

plot(x = electric_power[, "DateTime"],
     y = electric_power[, "Global_reactive_power"],
     type="l",
     xlab="datetime",
     ylab="Global Reactive Power")


dev.off()
