# plot4.R - Creates four distinct plots in a single file
# plot 1 - A line graph for Global Active Power over a Date Range
# plot 2 - A line graph for Voltage over a Date Range
# plot 3 - A line graph for Sub Metering 1, 2, and 3 over a Date Range
# plot 4 - A line graph for Global Reactive Power over a Date Range

# Unzip source file
if(!file.exists("./data")){dir.create("./data")}
unzip(zipfile="./exdata_data_household_power_consumption.zip",exdir="./data")

# Define Date Range for Plotting
start_date <- as.Date("1/2/2007","%d/%m/%Y")
end_date <- as.Date("2/2/2007","%d/%m/%Y")

# Read Source Data
test_1 <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                     colClasses = c("character","character","double","double",
                                    "double","double","double","double","double"))

# Create Date / Time Column
test_2 <- as.data.frame(strptime(paste(test_1$Date, test_1$Time), format = '%d/%m/%Y %H:%M:%S'))
colnames(test_2) <- "DATE_TIME"

# Join Date / Time Column to Initial Data set
test_3 <- cbind(test_2, test_1)
rm(test_1)
rm(test_2)

# Subset Data Set based on Date Range
test_4 <- subset(test_3, as.Date(Date,'%d/%m/%Y') >= start_date & as.Date(Date,'%d/%m/%Y') <= end_date)

# Create File
png("plot4.png", width=480, height=480, type="windows")
par(bg = "white")

par(mfrow = c(2,2))

# Create Graph = plot 1
xrange <- range(test_4$DATE_TIME)
yrange <- range(test_4$Global_active_power)
plot(xrange, yrange, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(test_4$DATE_TIME, test_4$Global_active_power, type = "l")

# Create Graph = plot 2
xrange <- range(test_4$DATE_TIME)
yrange <- range(test_4$Voltage)
plot(xrange, yrange, type = "n", xlab = "datetime", ylab = "Voltage")
lines(test_4$DATE_TIME, test_4$Voltage, type = "l")

# Create Graph - plot 3
plot(test_4$DATE_TIME, test_4$Sub_metering_1, xlab=NA, ylab="Energy sub metering",lty=1, lwd=1, pch=".", type="n")
lines(test_4$DATE_TIME, test_4$Sub_metering_1, lty=1, lwd=1, pch=".")
lines(test_4$DATE_TIME, test_4$Sub_metering_2, lty=1, lwd=1, pch=".", col="red")
lines(test_4$DATE_TIME, test_4$Sub_metering_3, lty=1, lwd=1, pch=".", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.7, lty=1, col=c("black","red","blue"), bty = "n")

# Create Graph = plot 
xrange <- range(test_4$DATE_TIME)
yrange <- range(test_4$Global_reactive_power)
plot(xrange, yrange, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(test_4$DATE_TIME, test_4$Global_reactive_power, type = "l")


dev.off()