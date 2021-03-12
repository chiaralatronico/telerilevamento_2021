# Il mio primo codice in R per il telerilevamento

setwd("D:/lab/") #windows
library(raster)

p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)
