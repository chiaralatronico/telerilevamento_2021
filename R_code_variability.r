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
the first pca contiene il ...


setwd("D:/lab/")
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
sent<-brick("sentinel.png")
sent <- brick("sentinel.png")
sentpca <- rasterPCA(sent)
plot(sentpca$map)
sentpca
summary(sentpca$model) 
#67.qualcosa% di variabilità spiegato attorno alla prima componente

#focal 

sentpca$map
#la prima componente si chiama pc1

pc1 <- sentpca$map$PC1
pc1sd5<-focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd5, col=clsd)

#su virtuale pezzo di codice 7x7
#lo salvo in lab in blocknotes con nome source.txt (in realtà va ftto save link as)
#in r con la funzione source richiamo il codice (carica codici dall'esterno)
source("source.txt")
 
install.packages("viridis")
library(viridis)

#importo altro codice
source("source_ggplot.r")

#faccio una nuova finestra vuota (con il + aggiungo dei blocchi)
ggplot()+

#le estetiche sono cosa plotto (sono le mapping)
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer))

ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()

#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
p1<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")

p2<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma")  +
ggtitle("Standard deviation of PC1 by magma colour scale")
#vengono fuori molto bene le parti con una alta dev.st

p3<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "inferno")  +
ggtitle("Standard deviation of PC1 by inferno colour scale")

#con grid.arrange metto insieme più mappe di ggplot
grid.arrange(p1, p2, p3, nrow=3)
#è il metodo con il quale il prof ci ha passato il codice pieno di mappe
