# Time series analysis
# Greenland increase of temperature 
# Data and code from Emanuela Cosma

#richiamo il pacchetto raster
library(raster)

#specifico il nuovo percorso di salvataggio dei dati
setwd("D:/lab/Greenland")

#installo il pacchetto rasterVis
install.packages("rasterVis")

#utilizzo la funzione raster per importare singolarmente le immagini lst relative a vari anni 
lst_2000 <- raster ("lst_2000.tif")

#dopo aver importato l'immagine relativa al 2000 posso farne il plot
plot(lst_2000)

#ripeto le due precedenti operazione per l'immagine lst del 2005
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)

#importo anche le immagini del 2010 e 2015
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")

#creo un multiframe 2x2 con le 4 immagini lst importate
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#creo un pacchetto contenente tutte e 4 le immagini lst

#con la funzione list.files creo prima la lista delle immagini
rlist <- list.files(pattern="lst")
rlist

 #con la funzione lapply applico la funzione raster alla lista appena creata
import <- lapply(rlist, raster)
import

#utilizzo la funzione stack per creare il pacchetto delle 4 immagini che chiamo Tgr
Tgr <- stack(import)

#lancio il plot del pacchetto per visualizzare contemporaneamente tutte e 4 le immagini
plot(Tgr)

#eseguo un plot RGB del pacchetto TGr a cui associo al livello del Red l'imm. del 2000, al livello del Green l'imm. del 2005 ed al Blue l'imm. del 2010
plotRGB(TGr, 1, 2, 3, stretch="Lin")

#plotRGB con le immagini del 2005, 2010 e 2015 nei rispettivi livelli Red, Green e Blue
plotRGB(TGr, 2, 3, 4, stretch="Lin")
























