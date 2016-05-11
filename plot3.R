
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

png("plot3.png")
ggplot(data = sumplot3d, aes(x = year, y = emissyear,
                             colour = type, group = type)) + 
    geom_line(size = 1) + facet_wrap(~type)
dev.off()

## Question 3.
## Of the four types of sources indicated by the type (point, nonpoint, onroad,
## nonroad) variable, which of these four sources have seen decreases in
## emissions from 1999-2008 for Baltimore City? Which have seen increases in
## emissions from 1999-2008? Use the ggplot2 plotting system to make a plot
## answer this question.

## Answer: Three types of emissions present a decrease in this period of
## time (NON-ROAD, NONPOINT and ON-ROAD), The POINT type emission presented an
## increase from the year 1999 to 2005 but after 2005 it is decreasing again.
