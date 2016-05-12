
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

plot6d <- subset(nei, fips == c("24510", "06037") & type == 'ON-ROAD')

sumplot6d <- plot6d %>%
    group_by(year, fips) %>%
    summarise(emissyear = sum(Emissions))

qplot(year, emissyear, data = sumplot6d , color=fips) + geom_line()

png("plot6.png")
qplot(year, emissyear, data = sumplot6d , color=fips) + geom_line() +
    ggtitle("Los Angeles 06037 vs. Baltimore 24510") +
    xlab("Year") +
    ylab("Emissions PM2.5")
dev.off()

## Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California (fips =
## "06037"). Which city has seen greater changes over time in motor vehicle 
## emissions?

## Answer: Los Angeles have seen greater changes over time in vehicle emissions
