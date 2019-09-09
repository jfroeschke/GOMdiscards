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

discards <- read.csv("data/discards.csv", stringsAsFactors = FALSE)
colnames(discards) <- c("Species", "Sector", "Gear",
                        "Year", "NumberDiscarded", "LbsDiscarded",
                        "LbsDeadDiscarded", "DiscardMortality")

# test from laptop
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
