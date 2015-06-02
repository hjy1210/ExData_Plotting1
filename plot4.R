# Please put file "household_power_consumption.txt" in working directory
lct <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")
consumption<-read.table(file="household_power_consumption.txt",
  header=TRUE,sep=";", colClasses=c("character","character",rep("numeric",7)),stringsAsFactors=FALSE,
  na.strings="?")
consumption$datetime=strptime(paste(consumption$Date,consumption$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
consumption$Date<-NULL
consumption$Time<-NULL
begindate<-strptime("01/02/2007","%d/%m/%Y")
enddate<-strptime("03/02/2007","%d/%m/%Y")
consumption<-consumption[consumption$datetime>=begindate & consumption$datetime<enddate,]
png(file="plot4.png", width = 480, height = 480, units = "px")
with(consumption, {
  par(mfrow=c(2,2))
  plot(datetime,Global_active_power,type='l', ylab="Global Active Power", xlab="")
  plot(datetime,Voltage,type='l',lty=1, ylab="Voltage", xlab="datetime")
  plot(datetime,Sub_metering_1,type='l',lty=1, ylab="Energy sub metering", xlab="")
  lines(datetime,Sub_metering_2,col='red' )
  lines(datetime,Sub_metering_3,col='blue')
  legend("topright", lty=1, col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  plot(datetime,Global_reactive_power,type='l', ylab="Global_reactive_power", xlab="datetime")
  })
dev.off()
Sys.setlocale("LC_TIME", lct)
