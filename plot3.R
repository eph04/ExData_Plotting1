################################################################################
## Files are in current working directory, set locale and load libraries

Sys.setlocale("LC_TIME", "en_US.UTF-8")

library(dplyr)
library(lubridate)

################################################################################
## Retrieve column classes and load data
df <- read.table("household_power_consumption.txt",header = TRUE,sep=";"
                 ,nrows = 100,stringsAsFactors = FALSE,na.strings = "?")
colClass <- sapply(df,class)
df <- read.table("household_power_consumption.txt",header = TRUE,sep=";"
                 ,colClasses = colClass,stringsAsFactors = FALSE,na.strings = "?")

################################################################################
## Convert date and time to proper data type and filter data on the days needed
df <- tbl_df(df)
df_clean <- df %>%
  mutate(Dttm=dmy_hms(paste(Date,Time,sep = " ")),Date=dmy(Date),Time=hms(Time)) %>%
  filter(Date==ymd("2007-02-01") | Date==ymd("2007-02-02"))
rm(df)

################################################################################
## Plot 3
# set labels and legend param
x_lab <- ""
y_lab <- "Energy sub metering"
main_title <- ""
legend_lab <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
col_legend_items <- c("black","red","blue")
# open graphic device
png(filename = "plot3.png",width = 480,height = 480,units = "px")
# create an empty graph (type="n")
plot(df_clean$Dttm,df_clean$Sub_metering_1
     ,type = "n",xlab = x_lab, ylab = y_lab,main = main_title)
# draw the lines based on each sub metering data
lines(df_clean$Dttm,df_clean$Sub_metering_1,col="black")
lines(df_clean$Dttm,df_clean$Sub_metering_2,col="red")
lines(df_clean$Dttm,df_clean$Sub_metering_3,col="blue")
# draw the legend
legend(x="topright",legend=legend_lab,col=col_legend_items,lty = 1, lwd=1)
# close graphic device and write the file
dev.off()
