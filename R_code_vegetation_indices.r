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

#calcolo il DVI (Difference Vegetation Index) per capire lo stato di salute della vegetazione
#DVI= riflettanza nel NIR - riflettanza nel RED
#digitando il nome dell'immagine + invio, posso leggere i nomi delle bande da unire ($) al nome immagine
dvi1<-defor1$defor1.1-defor1$defor1.2

#stampo il dvi1 ed ottengo una mappa in cui il valore di ogni pixel è dato dalla differenza dei valori della banda del NIR-RED
plot(dvi1)

#nuova palette di colori per la stampa del dvi1 
cl<-colorRampPalette(c("darkblue", "yellow", "red", "black")) (100)

#nuovo plot con la palette cl ed il titolo
plot(dvi1, col=cl, main="DVI at time 1")

#calcolo del secondo indice (dvi2) riferito alla seconda immagine (defor2)
dvi2<-defor2$defor2.1-defor2$defor2.2

#plot del dvi2, con palette cl e titolo
plot(dvi2, col=cl, main="DVI at time 2")

#multiframe con le stampe dei due indici insieme
par (mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

#per capire il cambiamento dello stato di salute della vegetazione nel tempo faccio una differenza tra i due indici
#la differenza è calcolata solo dove i due raster si sovrappongono (nel caso di estensioni differenti)
difdvi<-dvi1-dvi2

#nuova palette di colori
cld<-colorRampPalette(c("blue", "white", "red")) (100)

#stampo la differenza con la palette di colori impostata
plot(difdvi, col=cld)

#calcolo dell'NDVI, l'indice normalizzato, per il confronto tra immagini con risoluzione radiometrica diversa.
#NDVI = (NIR - RED)/(NIR + RED)
ndvi1<-(defor1$defor1.1-defor1$defor1.2)/(defor1$defor1.1+defor1$defor1.2)

#plot del ndvi1
plot(ndvi1, col=cl)

#calcolo dell'NDVI2 sulla immagine "defor2"
ndvi2<-(defor2$defor2.1-defor2$defor2.2)/(defor2$defor2.1+defor2$defor2.2)

#plot dell'ndvi2
plot(ndvi2, col=cl)

#con la funzione spectralIndices calcolo una serie di indici per ogni immagine
#gli argomenti sono il nome dell'immagine e i valori delle bande
vi1<-spectralIndices(defor1, green=3, red=2, nir=1)

#stampo i vari indici
plot(vi1, col=cl)

#calcolo e stampo i vari indici riferiti alla seconda immagine "defor2"
vi2<-spectralIndices(defor2, green=3, red=2, nir=1)
plot(vi2, col=cl)

#calcolo e stampo la differenza tra i due indici normalizzati
difndvi<-ndvi1-ndvi2
plot(difndvi, col=cld)
