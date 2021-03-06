library(dplyr)

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file_url, "my_data.zip", method = "curl")
unzip("my_data.zip",exdir = "my_data")

summarySCC_PM25 <- readRDS(file.path(getwd(), "my_data/summarySCC_PM25.rds"))
Source_Classification_Code <- readRDS(file.path(getwd(), "my_data/Source_Classification_Code.rds"))

plot1_data = summarySCC_PM25 %>%
  group_by(year) %>%
  summarise(PM25 = sum(Emissions, na.rm=TRUE))

png("plot1.png")

with(plot1_data, plot(year,PM25/1000000,
                      ylab = "Total PM2.5 Emissions (Millions)",
                      xlab = "Year",
                      title(main = "US PM2.5 Emissions"),
                      axes = F,
                      pch = 1
                      ))
box()
axis(2)
axis(1, at = plot1_data$year)
dev.off()
