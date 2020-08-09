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

png("plot1.png", width = 480, height = 480)

## make plot 1

hist(electric_data_subset$Global_active_power, 
     col = "red", 
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

## close png

dev.off()


