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
png(file="plot1.png", width = 480, height = 480, units = "px")
with(consumption, {
  hist(Global_active_power,col='red',main="Global Active Power", xlab="Global Active Power (kilowatts)")
  })
dev.off()
Sys.setlocale("LC_TIME", lct)
