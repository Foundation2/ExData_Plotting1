
# Download the zipped data and store in a temporary file

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

# Read in only the relevant rows of the data file
# coresponding to the two days to be analysed

EPCHeader <- read.table(unz(temp, "household_power_consumption.txt"), nrows = 1, sep =';', stringsAsFactors = FALSE)
EPCData <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", skip=66637,nrows=2880, na.strings="?")
colnames(EPCData) <- unlist(EPCHeader)

# Remove temporary file

unlink(temp)

# Transform Date field to date class; create datetime field

EPCData$datetime <- strptime(paste(EPCData$Date,EPCData$Time), format="%d/%m/%Y %H:%M:%S")
EPCData$Date <- as.Date(EPCData$Date, "%d/%m/%Y")


# Create time series plot Global Active Power and output as PNG file

png(filename = "plot2.png")
with (EPCData, plot(datetime, Global_active_power, type="l", xlab="", ylab = "Global Active Power (kilowatts)"))
dev.off()

