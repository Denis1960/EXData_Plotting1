plot4 <- function() 
{
  
  #set working directory to location of data and assign the filename
  setwd("c:/datasciencecoursera/Datasets")
  powerFile <- "household_power_consumption.txt"
  
  #Turn off warning messages generated from read/colClasses
  options(warn = -1)
  
  #read the file and make all column class types = character
  library(data.table)
  powerDT <- fread(powerFile,sep = ";",header = TRUE,
                   colClasses = c("character","character","numeric","numeric","numeric","numeric",
                                  "numeric","numeric","numeric"))
  
  #Format the date
  powerDT$Date <- as.Date(powerDT$Date,format="%d/%m/%Y")
  
  #Subset the date for days specified 2007-02-01 to 2007-02-02
  powerDT = subset(powerDT,powerDT$Date >= "2007-02-01" & powerDT$Date < "2007-02-03")
  
  #Create the timestamp to be used in graphs
  powerDT$dateTime <- as.POSIXct(strptime(paste(powerDT$Date, powerDT$Time, sep = " "),
                                          format = "%Y-%m-%d %H:%M:%S"))
  
  #Create the png device and then plot
  png(file = "plot4.png", width = 480, height = 480, units = "px")
  #Set up for 2 by 2 plot framework
  par(mfrow=c(2,2))
  plot_colors = c("black", "blue","red")
  
  #Graph 1
  
  plot(powerDT$dateTime,powerDT$Global_active_power, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  
  #Graph 2
  plot(powerDT$dateTime, powerDT$Voltage, type="l",
       xlab="datetime", ylab="Voltage")
  
  #Graph 3
  plot(powerDT$dateTime,powerDT$Sub_metering_1, type="l",
       ylab="Energy sub metering", xlab="", col=plot_colors[1])
  lines(powerDT$dateTime,powerDT$Sub_metering_2, type="l", col=plot_colors[2])
  lines(powerDT$dateTime,powerDT$Sub_metering_3, type="l", col=plot_colors[3])
  legend("topright", col = plot_colors,
         legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)
  
  #Graph 4
  plot(powerDT$dateTime, powerDT$Global_reactive_power, type="n",
       xlab="datetime", ylab="Global Reactive Power")
  lines(powerDT$dateTime,powerDT$Global_reactive_power)
  
  
  #Turn off the dev device
  dev.off()
  
}