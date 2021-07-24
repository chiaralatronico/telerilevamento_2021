#R_code_exam.r


#Analisi telerilevata dell'area del Montalbano in Toscana

#Immagini dell'8 giugno 2015 e del 30 ottobre 2016 da Landsat 8

# 1 -Combinazione tra bande: analisi del territorio attraverso le immagini a falso colore

#percorso di salvataggio dati
setwd("D:/Magistrale/1_anno/2_semestre/Tge/esame/")

#richiamo la libreria raster (pacchetto precedentemente installato)
library(raster)

#importo con la funzione brick le due immagini multi-banda dell'8/06/15 e del 30/10/2016
giugno15<-brick("landsat8_8giugno2015.tif")
ottobre16<-brick("landsat8_30ottobre7bande1.tif")

#nome immagine ed invio per leggerne le info
giugno15
ottobre16

#plot delle immagini nelle 7 bande 
plot(giugno15)
plot(ottobre16)

#Bande Landsat 8
# B1: Violet - Deep blue
# B2: Blue
# B3: Green
# B4: Red
# B5: Near Infrared (NIR)
# B6: (Short Wave Infrared) SWIR 1 
# B7: SWIR 2
