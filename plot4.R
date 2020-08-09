library(dplyr)

##  Read in the data
electric_data <- read.table('./exdata_data_household_power_consumption/household_power_consumption.txt', sep = ';', na.strings = "?", header = TRUE,
                            colClasses = c("character", "character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

# Date in format dd/mm/yyyy, time in  hh:mm:ss
electric_data <- mutate(electric_data, 
                        posix_date_time = as.POSIXlt(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"),
                        .keep = "unused",
                        .before = 1)

# Extract only data from the valid dates 2007-02-01 and 2007-02-02
electric_data_subset <- electric_data[!is.na(electric_data$posix_date_time) &
                                        electric_data$posix_date_time >= as.POSIXlt("2007-02-01") & 
                                        electric_data$posix_date_time < as.POSIXlt("2007-02-03"),]


## open png device

png("plot4.png", width = 480, height = 480)


## plot 4

par(mfrow = c(2, 2))

# plot 4a
plot(electric_data_subset$posix_date_time,
     electric_data_subset$Global_active_power, 
     type = "n",
     xlab = "",
     ylab = "Global Active Power")
lines(electric_data_subset$posix_date_time,
      electric_data_subset$Global_active_power, 
      pch = "")

# plot 4b
plot(electric_data_subset$posix_date_time,
     electric_data_subset$Voltage, 
     type = "n",
     xlab = "datetime",
     ylab = "Voltage")
lines(electric_data_subset$posix_date_time,
      electric_data_subset$Voltage, 
      pch = "")

# plot 4c
plot(electric_data_subset$posix_date_time,
     electric_data_subset$Sub_metering_1,
     type = "n",
     xlab = "",
     ylab = "Energy sub metering")
lines(electric_data_subset$posix_date_time,
      electric_data_subset$Sub_metering_1, 
      pch = "",
      col = "black")
lines(electric_data_subset$posix_date_time,
      electric_data_subset$Sub_metering_2, 
      pch = "",
      col = "red")
lines(electric_data_subset$posix_date_time,
      electric_data_subset$Sub_metering_3, 
      pch = "",
      col = "blue")
legend("topright",
       col = c("black","red","blue"),
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       lty = 1,
       bty = "n")

# plot 4d
plot(electric_data_subset$posix_date_time,
     electric_data_subset$Global_reactive_power, 
     type = "n",
     xlab = "datetime",
     ylab = "Global_reactive_power")
lines(electric_data_subset$posix_date_time,
      electric_data_subset$Global_reactive_power, 
      pch = "")

## close png

dev.off()