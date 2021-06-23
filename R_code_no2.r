#R_code_no2.r

#specifico il percorso di salvataggio della cartella EN
setwd("D:/lab/EN/")

#richiamo il pacchetto raster
library(raster)

#importo l'immagine con la funzione raster (per importare una sola banda, la prima)
EN01 <- raster("EN_0001.png")

#stabilisco una palette di colori per la stampa
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100)

#plot dell'immagine
plot(EN01, col=cl)

#il verde individua le zone con valori di NO2 più alto a Gennaio 2020

#importo l'immagine EN_0013 e la plotto
EN13<-raster("EN_0013.png")
plot(EN13, col=cl)

#i valori di NO2 a Marzo 2020 sono calati

#differenza tra i valori di NO2 nelle due mappe 
ENdiff <- EN13 - EN01

#plot di ENdiff
plot(ENdiff, col=cl)

#plot delle 3 immagine insieme
par(mfrow=c(1,3))
plot(EN01, col=cl, main="NO2 a Gennaio 2020")
plot(EN13, col=cl, main="NO2 a Marzo 2020")
plot(ENdiff, col=cl, main="Differenza Marzo-Gennaio")
