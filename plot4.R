fname <- 'data//household_power_consumption.txt'
output <- 'plot4.png'
startDate <- as.POSIXlt('2007-02-01')
endDate <- as.POSIXlt('2007-02-03')

power <- read.table(fname, header = T, sep = ';', stringsAsFactors = F)
power <- cbind(power,
               datetime = strptime(paste(power$Date, power$Time), '%d/%m/%Y %H:%M:%S'))
power <- power[which(power$datetime >= startDate), ]
power <- power[which(power$datetime <= endDate), ]
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
power$Voltage <- as.numeric(power$Voltage)
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)

par(mfrow = c(2, 2))
par(cex = 0.75)

# Global Active Power
with(power,
     plot(datetime, Global_active_power,
          type = 'l',
          xlab = '',
          ylab = 'Global Active Power'))

# Voltage
with(power, plot(datetime, Voltage, type = 'l'))

# Sub-metering
with(power,
     plot(datetime, Sub_metering_1,
          type = 'n',
          xlab = '',
          ylab = 'Energy sub metering'))
with(power, points(datetime, Sub_metering_1, type = 'l'))
with(power, points(datetime, Sub_metering_2, type = 'l', col = 'red'))
with(power, points(datetime, Sub_metering_3, type = 'l', col = 'blue'))
legend('topright', lwd = 1, bty = 'n',
       col = c('black', 'red', 'blue'),
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

# Global Reactive Power
with(power, plot(datetime, Global_reactive_power, type = 'l'))

dev.copy(png, file = output)
dev.off()
