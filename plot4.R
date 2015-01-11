# plot4.R
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

# Convert data subset to a data frame
class(d)
d <- data.frame(d)

# Convert columns to numeric
for(i in c(3:9)) {d[,i] <- as.numeric(as.character(d[,i]))}

# Create Date_Time variable
d$Date_Time <- paste(d$Date, d$Time)

# Convert Date_Time variable to proper format
d$Date_Time <- strptime(d$Date_Time, format="%Y-%m-%d %H:%M:%S")
class(d$Date_Time)


png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
d$Date = as.Date(d$Date, "%d/%m/%Y")
d$DateTime = as.POSIXct(paste(d$Date, d$Time), format="%Y-%m-%d %H:%M:%S")
# plot 1
n <- as.numeric(d$Global_active_power)
with(d,plot(DateTime, n, type='l', ylab='Global Active Power', xlab=''))
# plot 2
n <- as.numeric(d$Voltage)
with(d,plot(DateTime, n, type='l', ylab='Voltage', xlab='datetime'))
# plot 3


plot(d$Date_Time, d$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(d$Date_Time, d$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "red")
points(d$Date_Time, d$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# plot 4
n <- as.numeric(d$Global_reactive_power)
with(d,plot(DateTime, n, type='l', ylab='Global Reactive Power', xlab='datetime'))

dev.off()
