# plot3.R - Creates a Line Graph with legend showing the values for
#  Sub_metering_1, Sub_metering_2, and Sub_metering_3

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
png("plot3.png", width=480, height=480, type="windows")
par(bg = "white")

# Create Graph
plot(test_4$DATE_TIME, test_4$Sub_metering_1, xlab=NA, ylab="Energy sub metering",lty=1, lwd=1, pch=".", type="n")
lines(test_4$DATE_TIME, test_4$Sub_metering_1, lty=1, lwd=1, pch=".")
lines(test_4$DATE_TIME, test_4$Sub_metering_2, lty=1, lwd=1, pch=".", col="red")
lines(test_4$DATE_TIME, test_4$Sub_metering_3, lty=1, lwd=1, pch=".", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex=0.7, lty=1, col=c("black","red","blue"))

dev.off()