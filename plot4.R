## 1) Step 1 — pull first 1000000 rows from file 

d = read.table("household_power_consumption.txt", 
               sep=";", 
               na.strings="?",
               nrows=1000000, header=TRUE, stringsAsFactors=FALSE)

## 2) Step 2 — convert dates from char  format (as below) to one I can work with 

d$Date<-as.Date(d$Date, format="%d/%m/%Y") 

## 3) Filter data for 2007-02-01 and 2007-02-02  (these are the only dates needed for our analysis

d_final<-subset(d,Date>="2007-02-01" & Date<="2007-02-02")

## 4) Create a column that combines the Date and Time columns 

d_final$DateTime<-paste(d_final$Date,d_final$Time)

d_final$DateTime<-as.POSIXct(d_final$DateTime, format = "%Y-%m-%d %H:%M:%S")

## 5)  2 x 2 set of Plots — combining the above the plots with a Voltage plot  (the plot in the upper right hand corner)

par(mfrow=c(2,2))

plot(d_final$DateTime,d_final$Global_active_power, type="n",ylab="Global Active Power (kilowatts)",xlab=""); lines(d_final$DateTime,d_final$Global_active_power)

plot(d_final$DateTime,d_final$Voltage, type="n",ylab="Voltage",xlab="datetime"); lines(d_final$DateTime,d_final$Voltage)

plot(d_final$DateTime,d_final$Sub_metering_1, type="n",ylab="Energy sub metering",xlab="")
lines(d_final$DateTime,d_final$Sub_metering_1,col="gray")
lines(d_final$DateTime,d_final$Sub_metering_2,col="red")
lines(d_final$DateTime,d_final$Sub_metering_3,col="blue")

plot(d_final$DateTime,d_final$Global_reactive_power,ylab="Global_reactive_power",type="n"); lines(d_final$DateTime,d_final$Global_reactive_power)



