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

