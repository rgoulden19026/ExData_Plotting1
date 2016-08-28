# plot2.R - Creates a Line Graph for Global Active Power
#  over a specified Date Range

# Unzip source file
if(!file.exists("./data")){dir.create("./data")}
unzip(zipfile="./exdata_data_household_power_consumption.zip",exdir="./data")

# Define Date Range for plotting
start_date <- as.Date("1/2/2007","%d/%m/%Y")
end_date <- as.Date("2/2/2007","%d/%m/%Y")

# Read Source Data
test_1 <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                     colClasses = c("character","character","double","double",
                                    "double","double","double","double","double"))

# Create Date Time Column
test_2 <- as.data.frame(strptime(paste(test_1$Date, test_1$Time), format = '%d/%m/%Y %H:%M:%S'))
colnames(test_2) <- "DATE_TIME"

# Join Date Time Column to Initial Data Set
test_3 <- cbind(test_2, test_1)
rm(test_1)
rm(test_2)

# Define Subset based on Date Range
test_4 <- subset(test_3, as.Date(Date,'%d/%m/%Y') >= start_date & as.Date(Date,'%d/%m/%Y') <= end_date)

# Create Plot
xrange <- range(test_4$DATE_TIME)
yrange <- range(test_4$Global_active_power)
plot(xrange, yrange, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(test_4$DATE_TIME, test_4$Global_active_power, type = "l")

# Copy to PNG File
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()