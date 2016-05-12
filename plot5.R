
## Load all the needed libraries

library(dplyr)
library(ggplot2)

## File and URL variables

fileurl <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip")
filename <- ("exdata-data-NEI_data.zip")

## Download and unzip the files unless they already exists

if (!file.exists("Source_Classification_Code.rds") |
    !file.exists("summarySCC_PM25.rds")) {
    if (!file.exists("exdata-data-NEI_data.zip")) {
        download.file(fileurl, filename)
    }
    unzip("exdata-data-NEI_data.zip")
}

## Load and subset the data
## This first line will likely take a few seconds. Be patient!
nei <- tbl_df(readRDS("summarySCC_PM25.rds"))
scc <- tbl_df(readRDS("Source_Classification_Code.rds"))

## Subset the data we need, get all the sectors that contain "Coal", and filter
## only the ones that we need from the nei data set.

nei$SCC <- as.factor(nei$SCC)

plot5d <- subset(nei, fips == 24510 & type == 'ON-ROAD')

plot5d$year <- as.factor(plot5d$year)
sumplot5d <- plot5d %>%
    group_by(year) %>%
    summarise(emissyear = sum(Emissions))

png("plot5.png")
ggplot(sumplot5d, aes(x = year, y = emissyear)) +
    geom_bar(stat = "identity") +
    xlab("Year") +
    ylab("Emissions PM2.5") +
    ggtitle("Total emissions from motor vehicles in Baltimore")
dev.off()

## How have emissions from motor vehicle sources changed from 1999-2008 in
## Baltimore City?

## Answer: The emissions for motor vehicle sources have decreased conciderably
## in the period from 1999-2008
