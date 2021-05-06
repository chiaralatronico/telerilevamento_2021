#R_code_vegetation_indices.r

#percorso di salvataggio dei dati
setwd("D:/lab/")

#richiamo il pacchetto raster
library(raster)

#importo in R le due immagini riferite alla foresta amazzonica in due periodi differenti
defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")

#stampo un multiframe delle due immagini in RGB considerando che alla B1 è associato il NIR
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

