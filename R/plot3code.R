library(dplyr)
library(ggplot2)

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file_url, "my_data.zip", method = "curl")
unzip("my_data.zip",exdir = "my_data")

summarySCC_PM25 <- readRDS(file.path(getwd(), "my_data/summarySCC_PM25.rds"))
Source_Classification_Code <- readRDS(file.path(getwd(), "my_data/Source_Classification_Code.rds"))

plot3_data = summarySCC_PM25 %>%
  filter(fips == "24510") %>%
  group_by(year, type) %>%
  summarise(PM25 = sum(Emissions, na.rm=TRUE))

png("plot3.png")
ggplot(plot3_data, aes(year, PM25, color = type)) +
geom_point(na.rm = TRUE) +
labs(title = "Baltimore PM2.5 Emissions", x = "Year", y = "PM25 Emissions", color = "Type") +
geom_smooth(na.rm = TRUE) +
scale_x_continuous(breaks = plot5_data$year)
dev.off()
