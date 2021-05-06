#R_code_multivariate_analysis.r

#richiamo il percorso di salvataggio dei dati
setwd("D:/lab/")

#richiamo il pacchetto raster
library(raster)

#richiamo il pacchetto RStoolbox
library(RStoolbox)

#importo in R l'immagine della foresta sudamericana relativa al 2011
p224r63_2011<-brick("p224r63_2011_masked.grd")

#stampo l'immagine in tutte e 7 le bande
plot(p224r63_2011)

#analisi multivariata
#stampo uno scatter-plot tra i pixel associati alla banda del blu (B1_sre) e quelli della banda del verde (B2_sre)
#con l'argomento "col" stabilisco il colore dei punti del grafico; con l'argomento "pch" cambio il formato dei punti; con "cex" cambio la loro dimensione
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)

#con la funzione pairs genero un insieme di scatter-plot che pongono in correlazione ogni coppia di bande
pairs(p224r63_2011)

#ricampionamento dell'immagine con un fattore lineare pari a 10
p224r63_2011res<-aggregate(p224r63_2011, fact=10)

#nome dell'immagine e invio: ottengo le info sulla nuova immagine ricampionata che ha ora risoluzione del pixel pari a 300x300 m
p224r63_2011res

#stampo le due immagini (originale e ricampionata) su due righe e una colonna in infrarosso, montando la banda NIR sulla componente del red
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="Lin")

#con la funzione rasterPCA "compatto" l'immagine ricampionata in un numero minore di bande
p224r63_2011res_pca<-rasterPCA(p224r63_2011res)

#con la funziona summary ottengo un sommario del modello generato dalla funzione rasterPCA
summary(p224r63_2011res_pca$model)

#stampo l'immagine 
plot(p224r63_2011res_pca$map)

#stampo l'immagine in RGB
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="Lin")

