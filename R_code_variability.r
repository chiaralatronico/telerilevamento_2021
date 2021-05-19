#R_code_variability.r

#percorso di salvataggio dei file
setwd("D:/lab/")

#richiamo i pacchetti da utilizzare
library(raster)
library(RStoolbox)

#importo in R l'immagine Sentinel del Similaun (composta tra 3 livelli: NIR, Red, Green)
sent<-brick("sentinel.png")

#plot dell'immagine in RGB, montando NIR sulla componente Red, Red sulla Green e Green sulla Blue (non serve specificarlo)
plotRGB(sent, stretch="lin")

#
plotRGB(sent, r=2, g=1, b=3, stretch="lin")

#per il calcolo della dev.standard posso utilizzare una sola banda
#si utilizza la "finestra mobile" (moving window) di un'estensione di tot.pixel x tot.pixel in cui calcola la dev.st

#associo le bande dell'immagine a degli oggetti
nir <- sent$sentinel.1
red <- sent$sentinel.2

#calcolo l'ndvi
ndvi <- (nir-red) / (nir+red)

#stampo l'ndvi (ho calcolato un solo strato per calcolare la dev.st)
plot(ndvi)

#cambio la scala di colori
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100)

#nuova stampa 
plot(ndvi,col=cl)

#utilizzo la funzione focal per calcolare la dev.st.(sd) di una moving window (w) di 3x3 pixel (ndvisd3)
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) #
plot(ndvisd3, col=clsd)
#rosso e giallo dev.st più alta. verde e blu dev.st. più bassa. nelle parti più omogee della roccia nuda (blu) bassa. verde dal nuda a vegetata. omogena nelle parti vegetate
 
#calcolo la media
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)

#plot della  media
plot(ndvimean3, col=clsd)
#l'ndvi medio calcolato porterà a volir moli alti nelle praterie ad alta quaota...

#amplio la grandezza della moving window: 13x13 pixels
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
plot(ndvisd13)

ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd5, col=clsd)

#analisi multivariata
#calcolo della pca con la funzione PCA
sentpca<-rasterPCA(sent)
plot(sentpca$map)

sentpca

summary(sentpca$model)

