
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

coalscc <- select(filter(scc, grepl("Coal", scc$EI.Sector, 
                                    ignore.case = TRUE)), SCC)

coalscc <- as.vector(coalscc[["SCC"]])

plot4d <- filter(nei, SCC == coalscc)

plot4d$year <- as.character(plot4d$year)

sumplot4d <- plot4d %>%
    group_by(year) %>%
    summarise(emissyear = sum(Emissions))

png("plot4.png")
ggplot(data = sumplot4d, aes(x = year, y = emissyear)) + 
    geom_line(size = 1)
dev.off()

## Question 4. Across the United States, how have emissions from coal
## combustion-related sources changed from 1999-2008?

## Answer: Through the years, Sectors using Coal have been going up and down.
