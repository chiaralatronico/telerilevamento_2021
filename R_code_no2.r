#R_code_no2.r

#specifico il percorso di salvataggio della cartella EN
setwd("D:/lab/EN/")

#richiamo il pacchetto raster
library(raster)

library(RStoolbox)

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

#importo tutte le immagini del dataset
#con la funzione list.files creo la lista delle immagini
rlist <- list.files(pattern="EN_")
rlist

#con la funzione lapply applico la funzione raster alla lista appena creata
import <- lapply(rlist, raster)
import

#creo il "pacchetto" di tutte le immagini e lo plotto
EN <- stack(import)
plot(EN, col=cl)

#Replico i plot delle immagini EN01 e EN13 (i nomi delle immagini da legare con il $ sono quelli originali)
par(mfrow=c(2,1))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

#analisi multivariata del set
#con la funzione rasterPCA "compatto" il pacchetto immagini in un numero minore di bande
ENpca<-rasterPCA(EN)

#con la funzione summary ottengo un sommario del modello generato dalla funzione rasterPCA
summary(ENpca$model)

#stampo l'immagine 
plotRGB(ENpca$map, r=1, g=2, b=3, stretch="Lin")

#calcolo la variabilità locale (dev.st.) sulla prima componente principale
pc1st<-focal(ENpca$map$PC1, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(pc1st, col=cl)












