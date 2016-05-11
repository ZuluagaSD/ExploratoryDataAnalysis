
## Load all the needed libraries

library(dplyr)

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

plot2d <- tbl_df(subset(nei, fips == "24510"))

plot2d$year <- as.character(plot2d$year)

sumplot2d <- plot2d %>%
    group_by(year) %>%
    summarise(emissyear = sum(Emissions))

png("plot2.png")
plot(sumplot2d$year, sumplot2d$emissyear, type = "l",
     main = "Baltimore City emissions per year",
     xlab = "Year",
     ylab = "Total emissions")
dev.off()

## Question 2.
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make
## a plot answering this question.

## Answer: Yes, total emissions of PM2.5 in Baltimore City have decreased.
