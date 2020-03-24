library(data.table)
library(tidyverse)

electric_power <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Estimate memory
object.size(electric_power)

# Change date format
electric_power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter dates
electric_power <- electric_power %>%
    filter(Date >= "2007-02-01" & Date <= "2007-02-02")

# Create plot in png file

png("plot1.png", width=480, height=480)

hist(electric_power[, "Global_active_power"], 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     col="Red")

dev.off()

