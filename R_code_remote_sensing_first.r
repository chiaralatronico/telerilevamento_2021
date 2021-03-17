# Il mio primo codice in R per il telerilevamento


setwd("D:/lab/") #windows

#inserisco la funzione che richiama il pacchetto raster installato precedentemente con install.packages("raster")
library(raster)

p224r63_2011 <- brick("p224r63_2011_masked.grd")

#scrivo il nome dell'immagine per leggerne le informazioni
p224r63_2011

plot(p224r63_2011)

#cambio il colore delle immagini
cl <- colorRampPalette(c("black","grey","light grey")) (100)
plot(p224r63_2011, col=cl)

#nuvo cambio di colori
cl <- colorRampPalette(c("red","pink","purple")) (100)
plot(p224r63_2011, col=cl)
