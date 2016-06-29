plot3 <- function() 
{
  
  #set working directory to location of data and assign the filename
  setwd("c:/datasciencecoursera/Datasets")
  powerFile <- "household_power_consumption.txt"
  
  #read the file and make all column class types = character
  library(data.table)
  powerDT <- fread(powerFile,sep = ";",header = TRUE,
                   colClasses = rep("character",9))
  
  #Format the date
  powerDT$Date <- as.Date(powerDT$Date,format="%d/%m/%Y")
  
  #Subset the date for days specified 2007-02-01 to 2007-02-02
  powerDT = subset(powerDT,powerDT$Date >= "2007-02-01" & powerDT$Date < "2007-02-03")
  
  #Create the timestamp
  powerDT$dateTime <- as.POSIXct(strptime(paste(powerDT$Date, powerDT$Time, sep = " "),
                                          format = "%Y-%m-%d %H:%M:%S"))
  
  #Convert the power variable to numeric
  powerDT$Global_active_power <- as.numeric(powerDT$Global_active_power)
  powerDT$Sub_metering_1 <- as.numeric(powerDT$Sub_metering_1)
  powerDT$Sub_metering_2 <- as.numeric(powerDT$Sub_metering_2)
  powerDT$Sub_metering_3 <- as.numeric(powerDT$Sub_metering_3)
  
  #Create the png device and then plot
  plot_colors = c("black", "blue","red")
  png(file = "plot3.png", width = 480, height = 480, units = "px")
 
  plot(powerDT$dateTime,powerDT$Sub_metering_1, type="l",
       ylab="Energy sub metering", xlab="", col=plot_colors[1])
 
  lines(powerDT$dateTime,powerDT$Sub_metering_2, type="l", col=plot_colors[2])
  lines(powerDT$dateTime,powerDT$Sub_metering_3, type="l", col=plot_colors[3])
  
  legend("topright", col = plot_colors,
         legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty = 1)
  
  #Turn off the dev device
  dev.off()
  
}