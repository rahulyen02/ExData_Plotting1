library(chron) #loading library for using times function

#Step 1 - Getting and cleaning the data
raw_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
raw_data$Date <- as.Date(raw_data$Date, "%d/%m/%Y")
raw_data[,3:9] <- lapply(raw_data[,3:9], as.numeric)

#Step 2 - Subsetting the required data from the overall data
hh_power <- subset(raw_data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
hh_power$Time <- times(format(as.POSIXct(hh_power$Time, format = "%H:%M:%S")), "%H:%M:%S")
hh_power$Time <- strptime(paste(hh_power$Date, hh_power$Time), format = "%Y-%m-%d %H:%M:%S")

#Step 3 - Creating an empty PNG file and plotting the graphs
png(filename = "Plot4.png", height = 480, width = 480)

#Using par function with mfrow argument to construct 4 graphs on the same plot
par(mfrow = c(2,2))

plot(hh_power$Time, hh_power$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power")

plot(hh_power$Time, hh_power$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

plot(hh_power$Time, hh_power$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy Sub Metering")
lines(hh_power$Time, hh_power$Sub_metering_1, type = "l")
lines(hh_power$Time, hh_power$Sub_metering_2, type = "l", col = "red")
lines(hh_power$Time, hh_power$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1, col = c("black", "red", "blue"), box.lty = 0, inset = 0.02)

plot(hh_power$Time, hh_power$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Golobal_reactive_power")

dev.off()