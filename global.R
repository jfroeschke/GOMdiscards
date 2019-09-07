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
                        "LbsDeadDiscarded")

# test from laptop