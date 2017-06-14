#download and unzip data
fname <- "get.zip"
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", fname)
data <-read.table(unz(fname, "household_power_consumption.txt"), header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

##Convert date to Type Date
data$Date <- as.Date(data$Date, "%d/%m/%Y")

##Get scope from Feb. 1, 2007 to Feb. 2, 2007
data <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

##Clear incomplete observations
data <- data[complete.cases(data),]

##Prepare Date and Time
dateAndTime <- paste(data$Date, data$Time)
dateAndTime <- setNames(dateAndTime, "DateAndTime")

##Replace Date and Time column in data
data <- data[ ,!(names(data) %in% c("Date","Time"))]
data <- cbind(dateAndTime, data)

##Convert format
data$dateAndTime <- as.POSIXct(dateAndTime)

