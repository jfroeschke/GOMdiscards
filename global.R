## global.R
## global.R
library(tidyverse)
library(shiny)
library(shinydashboard)
library(highcharter)
library(shinyWidgets) # enhanced radio button
library(reshape2)
library(shinyBS)
library(shinyjs)
library(htmltools)
library(ggthemes)
library(RCurl)
library(png)
library(grid)
library(rintrojs)
library(DT)

discards <- read.csv("data/discards.csv", stringsAsFactors = FALSE)
colnames(discards) <- c("Species", "Sector", "Gear",
                        "Year", "NumberDiscarded", "LbsDiscarded",
                        "LbsDeadDiscarded", "DiscardMortality")

# Add commercial and recreational totals for red snapper
library(doBy)
x <- discards

rsAgg <- summaryBy(NumberDiscarded + LbsDiscarded +LbsDeadDiscarded 
                   ~ Species + Sector + Year  , data =x,
                   FUN=sum, id=c("Gear", "DiscardMortality"))
rsAgg2 <- data.frame(Species= rsAgg$Species,
                     Sector = rsAgg$Sector,
                     Gear = ifelse(rsAgg$Sector=="Commercial", "Total commercial","Total recreational"),
                     Year = rsAgg$Year,
                     NumberDiscarded = rsAgg$NumberDiscarded,
                     LbsDiscarded = rsAgg$LbsDiscarded,
                     LbsDeadDiscarded = rsAgg$LbsDeadDiscarded,
                     DiscardMortality = rsAgg$DiscardMortality)

discards <- rbind(discards, rsAgg2)

## clean up the data a bit.
discards[,5:7] <- round(discards[,5:7], 0)
discards[,8] <- round(discards[,8], 2)


# add a searchable datatable
discards2 <- discards
discards2[,5:7] <- round(discards2[,5:7], 0)
colnames(discards2) <- c("Species", "Sector", "Gear",
                         "Year", "Discards (numbers)", "Discards (lbs ww)",
                         "Dead discards (lbs ww)", "Discard mortality rate")
DT <- datatable(discards2, class = 'cell-border stripe',
          caption = 'Released fish data for select Gulf of Mexico species (1981 - 2016).',
          filter = 'top', options = list(
            pageLength = 15, autoWidth = TRUE
          ))

