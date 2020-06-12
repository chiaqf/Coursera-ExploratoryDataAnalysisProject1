power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

#Parse datetime column
subpower$Date <- as.Date(subpower$Date, format="%d/%m/%Y")
subpower$Time <- strptime(subpower$Time, format="%H:%M:%S")
subpower[1:1440,"Time"] <- format(subpower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpower[1441:2880,"Time"] <- format(subpower[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#plot 1
hist(as.numeric(subpower$Global_active_power),col="red",xlab="Global active power (kilowatts)",ylab="frequency",main="Global Active Power")

#plot2
plot(subpower$Time,as.numeric(as.character(subpower$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)") 

#giving it a title
title(main="Global Active Power Vs Time")

#plot3
plot(subpower$Time,subpower$Sub_metering_1,xlab="",ylab="Energy sub metering",col="black",type="l")
lines(subpower$Time,subpower$Sub_metering_2,col="red",type="l")
lines(subpower$Time,subpower$Sub_metering_3,col="blue",type="l")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#plot4
par(mfrow=c(2,2))
with(subpower,plot(Time,Global_active_power,type="l",ylab="Global Active Power"))
with(subpower,plot(Time,Voltage,type="l",ylab="Voltage",xlab="Datetime"))

plot(subpower$Time,subpower$Sub_metering_1,xlab="",ylab="Energy sub metering",col="black",type="l")
lines(subpower$Time,subpower$Sub_metering_2,col="red",type="l")
lines(subpower$Time,subpower$Sub_metering_3,col="blue",type="l")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

with(subpower,plot(Time,Global_reactive_power,type="l"))
