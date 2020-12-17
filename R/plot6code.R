library(dplyr)
library(gridExtra)

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(file_url, "my_data.zip", method = "curl")
unzip("my_data.zip",exdir = "my_data")

summarySCC_PM25 <- readRDS(file.path(getwd(), "my_data/summarySCC_PM25.rds"))
Source_Classification_Code <- readRDS(file.path(getwd(), "my_data/Source_Classification_Code.rds"))

plot6_sources = Source_Classification_Code %>%
  select(SCC, EI.Sector) %>%
  filter(grepl('On-Road', EI.Sector))

plot6_data = summarySCC_PM25 %>%
  filter(SCC %in% plot6_sources$SCC) %>%
  filter(fips == "24510" | fips == "06037") %>%
  group_by(year, fips) %>%
  summarise(PM25 = sum(Emissions, na.rm=TRUE))

plot6_Baltimore_data = plot6_data %>%
  filter(fips == "24510")

plot6_LA_data = plot6_data %>%
  filter(fips == "06037")

png("plot6.png")

BaltimorePlot <- ggplot(plot6_Baltimore_data, aes(year, PM25)) +
  geom_point(na.rm = TRUE) +
  labs(title = "Baltimore", x = "Year", y = "PM25 Emissions") +
  geom_smooth(na.rm = TRUE) +
  scale_x_continuous(breaks = plot6_data$year)

LAPlot <- ggplot(plot6_LA_data, aes(year, PM25)) +
  geom_point(na.rm = TRUE) +
  labs(title = "Los Angeles", x = "Year", y = "PM25 Emissions") +
  geom_smooth(na.rm = TRUE) +
  scale_x_continuous(breaks = plot6_data$year)

grid.arrange(BaltimorePlot, LAPlot, top = "Motor Vehicle PM2.5 Emissions", ncol=2)

dev.off()
