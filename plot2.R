library(dplyr)
library(lubridate)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("dataset.zip")){
    download.file(url, destfile = "dataset.zip")
    unzip("dataset.zip")
}
Electric_power_consumption<-read.csv("household_power_consumption.txt", header = TRUE, 
                                     sep = ";" , na = "?")

Data<-Electric_power_consumption %>%
    filter(Date == c("1/2/2007","2/2/2007") ) %>%
    collect()

Data$Date<-dmy(Data$Date)
Data <- mutate(Data, Time = as.POSIXlt(paste(Date, format(as.POSIXlt(Time, format = "%H:%M:%S"), '%T'))))

par(mfrow=c(1,1))
plot(x=Data$Time, y=Data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png,file = "plot2.png",width = 480, height = 480, units = "px")
dev.off()
