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

par(mfrow=c(1,1), cex.lab = 0.8, cex.axis = 0.8)

with (hpc_data, plot(DateTime, Sub_metering_1, type = "l",
        , main = "", xlab = "", ylab="Energy sub metering"))
lines(hpc_data$DateTime, hpc_data$Sub_metering_2, type = "l",col = "red")
lines(hpc_data$DateTime, hpc_data$Sub_metering_3, type = "l",col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c("solid", "solid", "solid"), col = c("black", "red", "blue"))
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
print("Done.")
