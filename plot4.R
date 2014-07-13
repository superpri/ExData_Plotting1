plot3 <- function(dateTime, csv2){
    plot(dateTime, csv2$Sub_metering_1, type = "l", main = "", ylab = "Energy sub metering", xlab = "")
    lines(dateTime,csv2$Sub_metering_3, type = "l", main = "", ylab = "", xlab = "", col ="blue")
    lines(dateTime,csv2$Sub_metering_2, type = "l", main = "", ylab = "", xlab = "", col = "red")
    legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), border="white" )
}


plot4 <- {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  destfile="exdata-data-household_power_consumption.zip",
                  method="wget")
    unzip("exdata-data-household_power_consumption.zip")
    
    # hid.csv
    # household_power_consumption.txt
    colNames = c("Date","Time","Global_active_power","Global_reactive_power",
                 "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                 "Sub_metering_3")
    
    #We will only be using data from the dates 2007-02-01 and 2007-02-02.
    csv <- read.table("household_power_consumption.txt",
                      header=TRUE,
                      col.names=colNames,
                      sep=";", 
                      dec=".",
                      na.strings="?")
    
    csv$Date <- as.Date(csv$Date, origin=as.Date("1900-01-01"), format="%d/%m/%Y")
    
    csv2 <- subset(csv, Date == as.Date('01/02/2007',origin=as.Date("1900-01-01"), format="%d/%m/%Y") 
                   | Date == as.Date('02/02/2007',origin=as.Date("1900-01-01"), format="%d/%m/%Y"))
    
    dateTime <- strptime( paste(csv2$Date,csv2$Time), format="%Y-%m-%d %H:%M:%S")
    
    png("plot4.png", width = 480, height = 480)
    layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))
    layout.show(4)
    plot(dateTime, csv2$Global_active_power, type = "l", main = "", ylab="Global Active Power", xlab="")
    plot(dateTime, csv2$Voltage, type = "l", main = "", ylab="Voltage", xlab="datetime")
    plot3(dateTime, csv2)
    plot(dateTime, csv2$Global_active_power, type = "l", main = "", ylab="Global Active Power", xlab="datetime")
    dev.off()
}