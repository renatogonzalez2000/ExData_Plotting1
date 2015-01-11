# plot1.R
# dates 2007-02-01 and 2007-02-02.
library(data.table)
data <- fread("household_power_consumption.txt")

######### Clean data #########

class(data$Date)
class(data$Time)
# Data and time variables are characters

# Change the format of Date variable
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
class(data$Date)

# Subset the data for the two dates of interest
d <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02"]

 # using lattice ploting system

png(filename = "plot1.png", width = 480, height = 480)
 hist(d$Global_active_power, main = "Global Active Power", ylab = "Frequency", 
      xlab = "Global Active Power (kilowatts)", col = "red", 
      breaks = 13, ylim = c(0,1200), xlim = c(0, 6), xaxp = c(0, 6, 3))
 
dev.off()

