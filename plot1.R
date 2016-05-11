
library(dplyr)

fileurl <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")
filename <- ("exdata-data-NEI_data.zip")

if (!file.exists("Source_Classification_Code.rds") |
    !file.exists("summarySCC_PM25.rds")) {
    if (!file.exists("exdata-data-NEI_data.zip")) {
        download.file(fileurl, filename)
    }
    unzip("exdata-data-NEI_data.zip")
}

## This first line will likely take a few seconds. Be patient!
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

plot1d <- tbl_df(subset(nei, year == c(1999, 2002, 2005, 2008)))
plot1d$year <- as.character(plot1d$year)

sumplot1d <- plot1d %>%
                group_by(year) %>%
                summarise(emissyear = sum(Emissions))

png("plot1.png")
plot(sumplot1d$year, sumplot1d$emissyear, type = "l",
     main = "Total emissions per year",
     xlab = "Year",
     ylab = "Total emissions")
dev.off()
