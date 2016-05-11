
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

plot1d <- tbl_df(subset(nei, year == c(1999, 2002, 2005, 2008)))
plot1d$year <- as.character(plot1d$year)

sumplot1d <- plot1d %>%
                group_by(year) %>%
                summarise(emissyear = sum(Emissions))

## Save the plot to file called plot1.png

png("plot1.png")
plot(sumplot1d$year, sumplot1d$emissyear, type = "l",
     main = "Total emissions per year",
     xlab = "Year",
     ylab = "Total emissions")
dev.off()

## Question 1.
## Have total emissions from PM2.5 decreased in the United States from 1999 to
## 2008? Using the base plotting system, make a plot showing the total PM2.5
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

## Answer: Yes, total emissions from PM2.5 have decreased.
