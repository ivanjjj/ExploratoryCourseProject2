library(dplyr)

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file_url, "my_data.zip", method = "curl")
unzip("my_data.zip",exdir = "my_data")

summarySCC_PM25 <- readRDS(file.path(getwd(), "my_data/summarySCC_PM25.rds"))
Source_Classification_Code <- readRDS(file.path(getwd(), "my_data/Source_Classification_Code.rds"))

plot2_data = summarySCC_PM25 %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(PM25 = sum(Emissions, na.rm=TRUE))

png("plot2.png")

with(plot2_data, plot(year,PM25,
                      ylab = "Total PM2.5 Emissions",
                      xlab = "Year",
                      title(main = "Baltimore PM2.5 Emissions"),
                      axes = F,
                      pch = 1
                      ))
box()
axis(2)
axis(1, at = plot2_data$year)
dev.off()
