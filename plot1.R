library("data.table")



#Reads in data from file then subsets data for specified dates
dataTXT <- read.table("household_power_consumption.txt",header=TRUE,dec=".",sep=";")

#Convert the date
dataTXT$Date<-as.Date(dataTXT$Date,format="%d/%m/%Y")
dataTXT$Global_active_power <- as.numeric(as.character(dataTXT$Global_active_power))

#Filter the date
extract<- dataTXT[(dataTXT$Date=="2007-02-01") | (dataTXT$Date=="2007-02-02"),]


png("plot1.png", width=480, height=480)

## Plot 1
hist(extract$Global_active_power, main = "Global Active Power", col="red"
     , xlab="Global Active Power (kilowatts)")

dev.off()