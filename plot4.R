library("data.table")

#Reads in data from file then subsets data for specified dates
dataTXT <- read.table("household_power_consumption.txt",header=TRUE,dec=".",sep=";")

#Convert the date
dataTXT$Date<-as.Date(dataTXT$Date,format="%d/%m/%Y")
dataTXT$Global_active_power <- as.numeric(as.character(dataTXT$Global_active_power))
dataTXT$Sub_metering_1 <- as.numeric(as.character(dataTXT$Sub_metering_1))
dataTXT$Sub_metering_2 <- as.numeric(as.character(dataTXT$Sub_metering_2))
dataTXT$Sub_metering_3 <- as.numeric(as.character(dataTXT$Sub_metering_3))
dataTXT$Global_reactive_power <- as.numeric(as.character(dataTXT$Global_reactive_power))
dataTXT$Voltage <- as.numeric(as.character(dataTXT$Voltage))


#Filter the date
extract<- dataTXT[(dataTXT$Date=="2007-02-01") | (dataTXT$Date=="2007-02-02"),]

#add new column withe date+time
extract <- transform(extract, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")


png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))


##PLOT 1
plot(extract$timestamp,extract$Global_active_power, type="l", xlab="", ylab="Global Active Power")

##PLOT 2
plot(extract$timestamp,extract$Voltage, type="l", xlab="datetime", ylab="Voltage")

##PLOT 3
plot(extract$timestamp,extract$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(extract$timestamp,extract$Sub_metering_2,col="red")
lines(extract$timestamp,extract$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  "
  , "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5)

#PLOT 4
plot(extract$timestamp,extract$Global_reactive_power, type="l", xlab="datetime"
     , ylab="Global_reactive_power")

dev.off()