
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
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

plot3d <- tbl_df(subset(nei, fips == "24510"))

plot3d$year <- as.character(plot3d$year)

sumplot3d <- plot3d %>%
    group_by(year, type) %>%
    summarise(emissyear = sum(Emissions))


qplot(sumplot3d$year, sumplot3d$emissyear, col = sumplot3d$type)

ggplot(data = sumplot3d,
       aes(x = year, y = emissyear, colour = type)) + geom_line()

png("plot3.png")
dev.off()

## Question 2.
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make
## a plot answering this question.

## Answer: Yes, total emissions of PM2.5 in Baltimore City have decreased.
