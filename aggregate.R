library(doBy)


x <- discards

rsAgg <- summaryBy(NumberDiscarded + LbsDiscarded +LbsDeadDiscarded 
                   ~ Species + Sector + Year  , data =x,
                   FUN=sum, id=c("Gear", "DiscardMortality"))
rsAgg2 <- data.frame(Species= rsAgg$Species,
                     Sector = rsAgg$Sector,
                     Gear = "Total commercial",
                     Year = rsAgg$Year,
                     NumberDiscarded = rsAgg$NumberDiscarded,
                     LbsDiscarded = rsAgg$LbsDiscarded,
                     LbsDeadDiscarded = rsAgg$LbsDeadDiscarded,
                     DiscardMortality = rsAgg$DiscardMortality)
discards <- rbind(discards, rsAgg2)
