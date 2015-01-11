# plot2.R
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

n <- as.numeric(d$Global_active_power)
png(filename = "plot2.png", width = 480, height = 480)
 d$Date = as.Date(d$Date, "%d/%m/%Y")
 d$DateTime = as.POSIXct(paste(d$Date, d$Time), format="%Y-%m-%d %H:%M:%S")
with(d,plot(DateTime, n, type='l', ylab='Global Active Power (kilowatts)', xlab=''))
dev.off()
