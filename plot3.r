#require(dplyr) #for cleaner DFs
#require(lubridate)
#load files
datafile <- "household_power_consumption.txt"
household.all <- read.csv(datafile, sep=";", stringsAsFactors = FALSE)
#consider commenting to avoid dplyr
#household.all <- tbl_df(household.all) #cleaner DFs

#convert dates
household.all$Date <-as.Date( household.all$Date, "%d/%m/%Y")
#subset for dates i want
dates <- c(as.Date("2007-02-02"),as.Date("2007-02-01"))
household.subset <- subset(household.all, Date %in% dates )
timedate.var <- paste0(as.character(household.subset$Date)," ",household.subset$Time)
household.subset$timedate <- strptime(timedate.var, "%Y-%m-%d %H:%M:%S")
# Data achieved, clean
rm("household.all")
rm("datafile")
rm("timedate.var")
#clean!

#Graph work!

household.subset$Global_active_power <- as.numeric(household.subset$Global_active_power)
png("plot3.png")
par(bg ="white")
#make lines graph
plot(household.subset$timedate, household.subset$Sub_metering_1, type="l", 
     xlab="", ylab="Energy sub metering")
lines(household.subset$timedate, household.subset$Sub_metering_2, type="l", col="red")
lines(household.subset$timedate, household.subset$Sub_metering_3, type="l", col="blue")
legend("topright", col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1)
dev.off()
rm("household.subset")