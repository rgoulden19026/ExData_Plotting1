# plot1.R - Reads source data and produces Histogram for
#   Global Active Power

# Unzip Source Data
if(!file.exists("./data")){dir.create("./data")}
unzip(zipfile="./exdata_data_household_power_consumption.zip",exdir="./data")

# Define time period to be plotted
start_date <- as.Date("1/2/2007","%d/%m/%Y")
end_date <- as.Date("2/2/2007","%d/%m/%Y")

# Read Source Data
test_1 <- read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", 
                     colClasses = c("character","character","double","double",
                                    "double","double","double","double","double"))

# Convert Date and Time to Date format
test_2 <- as.data.frame(as.Date(paste(test_1$Date, test_1$Time), format = '%d/%m/%Y %H:%M:%S'))
colnames(test_2) <- "DATE_TIME"

# Join DATE_TIME to data set
test_3 <- cbind(test_2, test_1)
rm(test_1)
rm(test_2)

# Extract Subset for Date Range
test_4 <- subset(test_3, DATE_TIME >= start_date & DATE_TIME <= end_date)

# Plot Histogram
hist(test_4$Global_active_power, breaks = 12, freq = TRUE, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

# Copy Histogram to PNG File
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()