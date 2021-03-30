# Il mio primo codice in R per il telerilevamento

#specifico il percorso di salvataggio della cartella lab (per Windows)
setwd("D:/lab/") 

#inserisco la funzione che richiama il pacchetto raster precedentemente installato con la funzione install.packages("raster")
library(raster)

#con la funzione birck importo un'unica immagine satellitare contenente tante immagini multi-banda e le associo il nome p224r63_2011
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#scrivo il nome dell'immagine e premo invio per leggerne le informazioni
p224r63_2011

#con la funzione plot R apre le 7 immagini in diverse bande
plot(p224r63_2011)

#con la funzione colorRampPalette posso cambiare la scala di colore delle immagini
#100 sono il n° di livelli di colore
#associo la funzione al nome cl
cl <- colorRampPalette(c("black","grey","light grey")) (100)

#chiedo ad R di stampare l'immagine con i nuovi colori impostati
plot(p224r63_2011, col=cl)

#nuovo cambio di colori e nuova stampa
cl <- colorRampPalette(c("red","pink","purple")) (100)
plot(p224r63_2011, col=cl)

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#dev.off() per ripulire la finestra grafica
dev.off()

#voglio plottare solo la banda 1. Con $ lego la banda 1 all'immagine satellitare totale
plot(p224r63_2011$B1_sre)

#nuovo plot della banda 1 con nuovi colori
cl <- colorRampPalette(c("grey", "yellow", "blue", "orange")) (100)
plot(p224r63_2011$B1_sre, col=cl)

#pulisco la finestra grafica
dev.off()

#Con par chiedo ad essere di impostare una certa configurazione grafica che specifico con mfrow 
par(mfrow=c(1,2))
#lancio i plot
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plot delle prime 4 bande Landsat sistemate su 4 righe e 1 colonna
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#2 righe e 2 colonne
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#associo una plette di colori che richiama il colore della lunghezza d'onda di ogni banda
par(mfrow=c(2,2))
clb<-colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)

clg<-colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col= clg)

clr<-colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)

cln<-colorRampPalette(c("green","yellow","blue")) (100)
plot(p224r63_2011$B3_sre, col=cln)

# Bande Landsat
# B1: blu
# B2: verde
# B3: rosso
# B4: infrarosso vicino
# B5: infrarosso medio
# B6: infrarosso termico
# B7: infrarosso medio

#plot dell'immagine della riserva brasiliana in RGB (colori reali) con uno strech lineare
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#visualizzo l'immagine in infrarosso montandolo sulla banda del rosso
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#sposto la banda 4 dell'infrarosso sulla banda del verde. 
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")

#sposto la banda dell'infrarosso sulla banda blu 
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#multiframe 2x2 con le precedenti 4 immagini
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#esporto il multiframe in pdf nella cartella lab e chiudo la finestra
pdf("prova_pdf.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

#plot dell'immagine con infrarosso sulla banda del verde e stretch a istogramma
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#multiframe 3x1 con tre immagini: in colori naturali RGB, con la banda dell'infrarosso sul verde con stretch lineare e con stretch a istogramma
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#installo il pacchetto RStoolbox
install.packages("RStoolbox")

#installo il pacchetto ggplot2
install.packages("ggplot2")







































