#' ----
#' title: " A script for aligning data from the TGN to findsorguk mints based on Pleiades IDs"
#' author: "Daniel Pett"
#' date: "10/16/2015"
#' output: csv_document
#' ----

setwd("C:\\rstuff")
# Download mints table from database
mints <- read.csv('finalMints.csv')
tgn <- read.csv('https://raw.githubusercontent.com/ryanfb/pleiades-tgn/master/pleiades-tgn.csv')
library(stringr)
tgnPleiades <- lapply(tgn$pleiadesID, function(replace)
{
  str_replace(replace, 'http://pleiades.stoa.org/places/', '')
})
tgn$pleiadesID2 <- unlist(tgnPleiades)
tgn <- tgn[,c(1,3)]
names(tgn) <- c('gettyID', 'pleiadesID')
final <- merge(mints, tgn, by='pleiadesID', all=TRUE )
library(plyr)
sort <- arrange(final,id)
write.csv(sort, file="mints.csv",row.names=FALSE)