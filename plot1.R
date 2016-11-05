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

hist(hpc_data$Global_active_power, col = "red", main = "Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()
print("Done.")
