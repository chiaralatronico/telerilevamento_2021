#R_code_variability.r

#percorso di salvataggio dei file
setwd("D:/lab/")

#richiamo i pacchetti da utilizzare
library(raster)
library(RStoolbox)

#importo in R l'immagine Sentinel del Similaun (composta tra 3 livelli: NIR è la Banda 1, Red è la Banda 2, Green è la Banda 3)
sent<-brick("sentinel.png")

#plot dell'immagine in RGB, montando il NIR sulla componente Red, il Red sulla Green e il Green sulla Blue (non serve specificarlo)
plotRGB(sent, stretch="lin")

#sposto il NIR sulla componente Green: la vegetazione sarà verde fluo
plotRGB(sent, r=2, g=1, b=3, stretch="lin")

#per il calcolo della dev.standard si utilizza la "finestra mobile" (moving window) di un'estensione di tot.pixel x tot.pixel 
#essa passa in una sola banda dell'immagine e calcola di volta in volta la dev.st. dei pixel dell'immagine a cui fa riferimento
#per poterla usare posso calcolare l'ndvi dell'immagine in modo da creare un unico layer su cui calcolare la dev. st.

#rinomino le bande sentinel.1 e sentinel.2 dell'immagine sent
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

#con la funzione focal calcolo la dev. st. (sd) sull'ndvi con una finestra mobile di 3x3 pixel (w) 
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
plot(ndvisd3)

#cambio la palette di colori
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 
plot(ndvisd3, col=clsd)
#rosso e giallo dev.st più alta. Verde e blu dev.st. più bassa. 
#La dev.st. in blu è molto bassa nelle parti più omogenee della roccia nuda, mentre aumenta ed è più verde verde dalla roccia nuda alle aree vegetate. 
#è omogenea nelle parti vegetate 

#calcolo la media (è la media della biomassa all'interno dell'immagine)
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)

#plot della media
plot(ndvimean3, col=clsd)
#l'ndvi medio calcolato porterà a valori moli alti nelle praterie ad alta quaota, alti nei boschi, più bassi nella roccia nuda

#amplio la grandezza della moving window: 13x13 pixels
ndvisd13 <- focal(ndvi, w=matrix(1/169, nrow=13, ncol=13), fun=sd)
plot(ndvisd13)

#moving window di 5x5 pixels
ndvisd5 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd5, col=clsd)

#per caclolare la dev. st. su un uncio strato dell'immagine posso anche fare un'analisi multivariata
#calcolo la PCA con la funzione rasterPCA
sentpca<-rasterPCA(sent)

#plot delle 4 mappe della sentpca (la prima, la pc1, è quella che per definizione ha maggiori info)
plot(sentpca$map)

#summary del modello della pca per leggere la % di variabilità spiegata dalle singole componenti
summary(sentpca$model)
#la pc1 spiega il 67.36% dell'informazione originale



setwd("D:/lab/")
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
sent<-brick("sentinel.png")
sentpca <- rasterPCA(sent)
plot(sentpca$map)
sentpca
summary(sentpca$model) 

#chiamo pc1 la prima componente delle mappe
pc1<-sentpca$map$PC1

#caclolo la dev. st. (sd) sulla pc1 con una moving window di 5x5
pc1sd5<-focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)

#imposto una nuova palette di colori e plotto l'immagine
clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pc1sd5, col=clsd)
#l'aumento di variabilità è riscontrabile nelle zone di roccia

#su virtuale leggo un pezzo di codice per il calcolo della dev.st con una moving window 7x7
#salvo tale codice nella cartella lab con nome source_test_lezione.r
#in R con la funzione source richiamo il codice (carica codici dall'esterno)
source("source_test_lezione.r")
 
install.packages("viridis")
library(viridis) #serve per colorare i plot di ggplot in modo automatico

#importo in R un altro codice dall'esterno
source("source_ggplot.r")

#creo una nuova finestra vuota (con il + aggiungo ulteriori comandi)
ggplot()+

#con la funzione geom_raster specifico qual è l'oggetto del plot (un raster). Con l'arg. mapping specifico le estetiche, cioè che cosa voglio plottare (x, y, ed il layer della mappa)
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer))

#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
#con la funzione scale_fill_viridis() seleziono la scala di colori (in questo caso è quella di default)
ggplot() + 
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) + 
scale_fill_viridis()

#aggiungo un titolo
p1<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis()  +
ggtitle("Standard deviation of PC1 by viridis colour scale")

#cambio la scala di colori, scelgo "magma"
p2<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma")  +
ggtitle("Standard deviation of PC1 by magma colour scale")

#scala di colori "inferno"
p3<-ggplot() +
geom_raster(pc1sd5, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "inferno")  +
ggtitle("Standard deviation of PC1 by inferno colour scale")

#con grid.arrange plotto più mappe insieme
grid.arrange(p1, p2, p3, nrow=1)

