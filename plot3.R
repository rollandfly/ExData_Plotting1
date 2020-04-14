library("data.table")

#Reads in data from file then subsets data for specified dates
dataTXT <- read.table("household_power_consumption.txt",header=TRUE,dec=".",sep=";")

#Convert the date
dataTXT$Date<-as.Date(dataTXT$Date,format="%d/%m/%Y")
dataTXT$Global_active_power <- as.numeric(as.character(dataTXT$Global_active_power))
dataTXT$Sub_metering_1 <- as.numeric(as.character(dataTXT$Sub_metering_1))
dataTXT$Sub_metering_2 <- as.numeric(as.character(dataTXT$Sub_metering_2))
dataTXT$Sub_metering_3 <- as.numeric(as.character(dataTXT$Sub_metering_3))

#Filter the date
extract<- dataTXT[(dataTXT$Date=="2007-02-01") | (dataTXT$Date=="2007-02-02"),]

#add new column withe date+time
extract <- transform(extract, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")


png("plot3.png", width=480, height=480)

## Plot 3
plot(extract$timestamp,extract$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(extract$timestamp,extract$Sub_metering_2,col="red")
lines(extract$timestamp,extract$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
#dev.copy(png, file="plot3.png", width=480, height=480)


dev.off()