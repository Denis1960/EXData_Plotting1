plot1 <- function() 
{
  
  #set working directory to location of data
  setwd("c:/datasciencecoursera/Datasets")
  powerDT <- read.table("household_power_consumption.txt", header=TRUE, sep=";")
  
  #Format the timestamp
  powerDT$Timestamp <- strptime(paste(powerDT$Date,powerDT$Time),
                             format="%d/%m/%Y %H:%M:%S")
  
  
  #Subset the date for days specified 2007-02-01 to 2007-02-02
  powerDT = subset(powerDT,as.Date(powerDT$Timestamp) >= "2007-02-01" 
                    & as.Date(powerDT$Timestamp) < "2007-02-03")
  
  #Convert the power variable to numeric
  powerDT$Global_active_power <- as.numeric(as.character(powerDT$Global_active_power))
  
  #Create the plot
  hist(powerDT$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power ( in kilowatts)")
  
  #Save the plot to disk
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  
}