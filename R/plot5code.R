library(dplyr)
library(ggplot2)

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file_url, "my_data.zip", method = "curl")
unzip("my_data.zip",exdir = "my_data")

summarySCC_PM25 <- readRDS(file.path(getwd(), "my_data/summarySCC_PM25.rds"))
Source_Classification_Code <- readRDS(file.path(getwd(), "my_data/Source_Classification_Code.rds"))

plot5_sources = Source_Classification_Code %>%
  select(SCC, EI.Sector) %>%
  filter(grepl('On-Road', EI.Sector))

plot5_data = summarySCC_PM25 %>%
  filter(SCC %in% plot5_sources$SCC) %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(PM25 = sum(Emissions, na.rm=TRUE))

png("plot5.png")
ggplot(plot5_data, aes(year, PM25)) +
geom_point(na.rm = TRUE) +
labs(title = "Motor Vehicle PM2.5 Emissions in Baltimore", x = "Year", y = "PM25 Emissions") +
geom_smooth(na.rm = TRUE) +
scale_x_continuous(breaks = plot5_data$year)
dev.off()
