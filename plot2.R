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
## Plot 2
# set labels
x_lab <- ""
y_lab <- "Global Active Power (kilowatt)"
main_title <- ""
# open graphic device
png(filename = "plot2.png",width = 480,height = 480,units = "px")
# create an empty graph (type="n")
plot(df_clean$Dttm,df_clean$Global_active_power
     ,type = "n",xlab = x_lab, ylab = y_lab,main = main_title)
# draw the line based on data
lines(df_clean$Dttm,df_clean$Global_active_power)
# close graphic device and write the file
dev.off()
