fname <- 'data//household_power_consumption.txt'
output <- 'plot3.png'
startDate <- as.POSIXlt('2007-02-01')
endDate <- as.POSIXlt('2007-02-03')

power <- read.table(fname, header = T, sep = ';', stringsAsFactors = F)
power <- cbind(power,
               'Date/Time' = strptime(paste(power$Date, power$Time), '%d/%m/%Y %H:%M:%S'))
power <- power[which(power$'Date/Time' >= startDate), ]
power <- power[which(power$'Date/Time' <= endDate), ]
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)

plot(power$'Date/Time',
     power$Sub_metering_1,
     type = 'n',
     xlab = '',
     ylab = 'Energy sub metering')
points(power$'Date/Time',
       power$Sub_metering_1,
       type = 'l')
points(power$'Date/Time',
       power$Sub_metering_2,
       type = 'l',
       col = 'red')
points(power$'Date/Time',
       power$Sub_metering_3,
       type = 'l',
       col = 'blue')
legend('topright', lwd = 1,
       col = c('black', 'red', 'blue'),
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

dev.copy(png, file = output)
dev.off()
