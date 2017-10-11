household_power <- read.table(file = "./data/household_power_consumption.txt", sep = ";", header = FALSE, skip = 66637, nrows = 2880)
household_power_names <- read.table(file = "./data/household_power_consumption.txt", sep = ";", header = FALSE, nrows = 1,colClasses = "character")
names(household_power) <- as.character(household_power_names)
household_power[,1] <- dmy(household_power[,1])

Beginning <- "2007-02-01 00:00:00"
household_power <- mutate(household_power, daytime = as.numeric(difftime(as.POSIXlt(paste(Date, Time)), as.POSIXlt(Beginning),units = 'days')))
household_power[,3] <- as.numeric(household_power[,3])

png(filename = "./data/plot3.png" , width = 480, height = 480)
with(household_power, plot(daytime, Sub_metering_1, type = "l", xlab = "", ylab = "Global Active Power (killowatts)", xaxt = "n"))
points(household_power$daytime, household_power$Sub_metering_1, col = "black", type = "l")
points(household_power$daytime, household_power$Sub_metering_2, col = "red", type = "l")
points(household_power$daytime, household_power$Sub_metering_3, col = "blue", type = "l")
axis(side = 1, at = 0:2, labels = c("Thu", "Fri", "Sat"))
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()