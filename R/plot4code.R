library(dplyr)
library(ggplot2)

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file_url, "my_data.zip", method = "curl")
unzip("my_data.zip",exdir = "my_data")

summarySCC_PM25 <- readRDS(file.path(getwd(), "my_data/summarySCC_PM25.rds"))
Source_Classification_Code <- readRDS(file.path(getwd(), "my_data/Source_Classification_Code.rds"))

plot4_sources = Source_Classification_Code %>%
  select(SCC, EI.Sector) %>%
  filter(grepl('Coal', EI.Sector))

plot4_data = summarySCC_PM25 %>%
  filter(SCC %in% plot4_sources$SCC) %>%
  group_by(year) %>%
  summarise(PM25 = sum(Emissions, na.rm=TRUE))

png("plot4.png")
ggplot(plot4_data, aes(year, PM25/1000)) +
geom_point(na.rm = TRUE) +
labs(title = "Coal PM2.5 Emissions in US", x = "Year", y = "PM25 Emissions (Thousands)") + geom_smooth(na.rm = TRUE) +
scale_x_continuous(breaks = plot5_data$year)
dev.off()
