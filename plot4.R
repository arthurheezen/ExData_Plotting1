# Bring in the data tables and lubridate packages
library(data.table)
library(lubridate)

# Change to the working directory
setwd("C:\\Users\\Michelle\\Google Drive\\data\\DS4ExDatAnal\\ExData_Plotting1")

# Load the household power consumption file
HPC<-read.table(
  "household_power_consumption.txt"
  ,header=TRUE
  ,sep=";"
  ,na.strings="?"
  ,col.names=c(
    "Date"
    ,"Time"
    ,"Global_active_power"
    ,"Global_reactive_power"
    ,"Voltage"
    ,"Global_intensity"
    ,"Sub_metering_1"
    ,"Sub_metering_2"
    ,"Sub_metering_3"))

# Subset to the two days of interest
HPC <-subset(HPC, Date=="1/2/2007" | Date=="2/2/2007")

# Convert to a data table
HPC <- data.table(HPC)

# Make a datetime field
HPC[,ObsDateTime:=dmy_hms(paste(Date,Time," "))]

# Start the plot
png("plot4.png")
par(mfrow = c(2,2))

# Upper left quadrant
mfg=c(1,1)
plot(HPC$ObsDateTime,HPC$Global_active_power,type="l",ylab="Global Active Power (kilowatts)")

# Upper right quadrant
mfg=c(1,2)
plot(HPC$ObsDateTime,HPC$Voltage,type="l",xlab="datetime",ylab="Voltage")

# Lower left quadrant
mfg=c(2,1)
plot(HPC$ObsDateTime,HPC$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(HPC$ObsDateTime,HPC$Sub_metering_1,col="black")
lines(HPC$ObsDateTime,HPC$Sub_metering_2,col="red")
lines(HPC$ObsDateTime,HPC$Sub_metering_3,col="blue")
legend(
  "topright"
  ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  ,col=c("black","red","blue")
  ,lwd=2
  ,lty=c(1,1,1))
  
# Lower right quadrant
mfg=c(2,2)
plot(HPC$ObsDateTime,HPC$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

# Finish the file
dev.off()
