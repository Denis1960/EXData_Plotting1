plot1 <- function() 
{
  
  #set working directory to location of data
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
  #Convert the power variable to numeric
  powerDT$Global_active_power <- as.numeric(as.character(powerDT$Global_active_power))
  
  #Create the plot
  hist(powerDT$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power ( in kilowatts)")
  
  #Save the plot to disk
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  
}