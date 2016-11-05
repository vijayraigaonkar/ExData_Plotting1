rm(list=ls())

print("Reading file...")

hpc_data_all <- read.csv("household_power_consumption.txt", header=TRUE, sep=";",
                        dec =".", colClasses=c("character", "character", "numeric", "numeric",
                                               "numeric", "numeric", "numeric", "numeric", "numeric"),
                        na.strings = c("?"),comment.char=""
                        )

dates2use <- c("1/2/2007", "2/2/2007")

hpc_data <- hpc_data_all[hpc_data_all$Date %in% dates2use,]

rm("hpc_data_all")

print("Data read. Plotting and writing to plot1.png...")

hpc_data$DateTime <- strptime(paste(hpc_data$Date, " ", hpc_data$Time), "%d/%m/%Y %H:%M:%S")

par(mfrow=c(2,2), cex.lab = 0.8, cex.axis = 0.8)

plot(hpc_data$DateTime, hpc_data$Global_active_power, type = "l", main = "",
     xlab = "", ylab="Global active power")
plot(hpc_data$DateTime, hpc_data$Voltage, type = "l", main = "",
     xlab = "datetime", ylab="Voltage")
plot(hpc_data$DateTime, hpc_data$Sub_metering_1, type = "l", main = "",
     xlab = "", ylab="Energy sub metering")
lines(hpc_data$DateTime, hpc_data$Sub_metering_2, type = "l",col = "red")
lines(hpc_data$DateTime, hpc_data$Sub_metering_3, type = "l",col = "blue")
legend(legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c("solid", "solid", "solid"), col = c("black", "red", "blue"),
       cex = 0.6, bty = "n", x = mean(hpc_data$DateTime), y = max(hpc_data$Sub_metering_1) + 3, xjust=0.3)
plot(hpc_data$DateTime, hpc_data$Global_reactive_power, type = "l", main = "",
     xlab = "Datetime", ylab="Global Reactive Power")

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
print("Done.")
