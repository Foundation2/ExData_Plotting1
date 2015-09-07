
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

# Create histogram of Global Active Power and output as PNG file

png(filename = "plot1.png")
hist(EPCData$Global_active_power, col="red", main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()