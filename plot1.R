fname <- 'data//household_power_consumption.txt'
output <- 'plot1.png'
startDate <- as.POSIXlt('2007-02-01')
endDate <- as.POSIXlt('2007-02-03')

power <- read.table(fname, header = T, sep = ';', stringsAsFactors = F)
power <- cbind(power,
               datetime=strptime(paste(power$Date, power$Time), '%d/%m/%Y %H:%M:%S'))
power <- power[which(power$datetime >= startDate), ]
power <- power[which(power$datetime <= endDate), ]
power$Global_active_power <- as.numeric(power$Global_active_power)

hist(power$Global_active_power, 
     col = 'red',
     main = 'Global Active Power',
     xlab = 'Global Active Power (kilowatts)')

dev.copy(png, file = output)
dev.off()
