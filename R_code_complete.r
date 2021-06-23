#R code complete - Telerilevamento Geo-Ecologico

#-------------------------------------------------

#Summary:

# 1. Remote sensing first code
# 2. R code time series
# 3. R code Copernicus data
# 4. R code knitr
# 5. R code multivariate analysis
# 6. R code classification 
# 7. R code ggplot2
# 8. R code vegetation indices
# 9. R code land cover
#10. R code variability

#-------------------------------------------------

# 1. Remote sensing first code

# Il mio primo codice in R per il telerilevamento

#specifico il percorso di salvataggio della cartella lab (per Windows)
setwd("D:/lab/") 

#installo il pacchetto raster
install.packages("raster")

#inserisco la funzione che richiama il pacchetto raster
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


#importo in R il blocco di immagini relative al 1998 e gli associo il nome p224r63_1988
p224r63_1988 <- brick ("p224r63_1988_masked.grd")

#info sul nuovo file
p224r63_1988

#plot del nuovo file nelle singole 7 bande
plot(p224r63_1988)

#plot in RGB dell'immagine a colori naturali
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

#plot dell'immagine in RGB in falsi colori (con la banda del NIR montata sulla componente del Red)
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#multiframe RGB a colori naturali delle due immagini del 1988 e del 2011
par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#pdf di un multiframe 2x2 in falsi colori (NIR sulla componente Red) delle immagini del 1988 e 2011 con stretch lineare e ad istogramma
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()

#-------------------------------------------------

# 2. R code time series

# Time series analysis
# Greenland increase of temperature 
# Data and code from Emanuela Cosma

#richiamo il pacchetto raster
library(raster)

#specifico il nuovo percorso di salvataggio dei dati
setwd("D:/lab/Greenland")

#installo il pacchetto rasterVis
install.packages("rasterVis")

#richiamo il pacchetto rasterVis
library(rasterVis)

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

#utilizzo la funzione stack per creare il pacchetto delle 4 immagini che chiamo TGr
TGr <- stack(import)

#lancio il plot del pacchetto per visualizzare contemporaneamente tutte e 4 le immagini
plot(TGr)

#eseguo un plot RGB del pacchetto TGr a cui associo al livello del Red l'imm. del 2000, al livello del Green l'imm. del 2005 ed al Blue l'imm. del 2010
plotRGB(TGr, 1, 2, 3, stretch="Lin")

#plotRGB con le immagini del 2005, 2010 e 2015 nei rispettivi livelli Red, Green e Blue
plotRGB(TGr, 2, 3, 4, stretch="Lin")

#utilizzo la funzione levelplot per fare il plot delle 4 immagini con un'unica legenda
levelplot(TGr)

#riapplico la funzione levelplot al blocco di immagini TGr per visualizzare solo quella relativa al 2000
levelplot(TGr$lst_2000)

#nuova palette di colori
cl<-colorRampPalette(c("blue","light blue","pink","red")) (100)

#ri-plotto le 4 immagini TGr con i nuovi colori utilizzando la funzione levelplot con l'argomento col.regions
levelplot(TGr, col.regions=cl)

#rinomino le 4 immagini (attributi) con la funzione levelplot e l'argomento names.attr 
levelplot(TGr, col.regions=cl, names.attr=c("July 2000", "July 2005", "July 2010", "July 2015"))

#inserisco anche un titolo alla mappa con l'argomento main
levelplot(TGr, col.regions=cl, main="LST variation in time", names.attr=c("July 2000", "July 2005", "July 2010", "July 2015"))



#nuova analisi sullo scioglimento del ghiaccio in Groenlandia

#faccio una lista delle immagini dal 1979 al 2007 relative allo scioglimento del ghiaccio
meltlist<-list.files(pattern="melt")

#importo la lista creata con lapply e le applico la funzione raster
melt_import<-lapply(meltlist, raster)

#raggruppo i file importati con la funzione stack
melt<-stack(melt_import)

#visualizzo i valori, le info, di melt 
melt

#faccio un plot delle immagini
levelplot(melt)

#per capire l'avanzamento dello scioglimento del ghiaccio faccio una differenza algebrica tra l'immagine del 2007 (maggior scioglimento) e quella del 1979 (minor scioglim.)
melt_amount<-melt$X2007annual_melt-melt$X1979annual_melt

#creo una nuova palette di colori da applicare al melt_amount
clb<-colorRampPalette(c("blue","white","red")) (100)

#faccio il plot del melt_amount
plot(melt_amount, col=clb)

#altro plot ma con la funzione levelplot
levelplot(melt_amount, col.regions=clb)

#-------------------------------------------------

# 3. R code Copernicus data

#R_code_copernicus.r
#Visualizing Copernicus data

#installo il pacchetto ncdf4
install.packages("ncdf4")

#richiamo il pacchetto ncdf4
library(ncdf4)

#richiamo il pacchetto raster
library(raster)

#specifico il percorso di salvatggio dei dati scaricati
setwd("D:/lab/")

#importo il file relativo all'albedo scaricato dal sito (land.copernicus...sezione energy budget) con la funzione raster e gli associo il nome "albedo"
albedo<-raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")

#creo una nuova palette di colori
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100)

#stampo l'immagine con la nuova palette di colori
plot(albedo, col=cl)

#ricampionamento bilineare: utilizzo la funzione aggregate per ricampionare (diminuiure il numero di pixel) l'immagine; con l'argomento fact specifico tale diminuizione lineare 
albedores<-aggregate (albedo, fact=100)

#stampo la nuova immagine ricampionata
plot(albedores, col=cl)

#installo il pacchetto knitr
install.packages("knitr")

#installo il pacchetto RStoolbox
install.packages("RStoolbox")

#-------------------------------------------------

# 4. R code knitr

#R_code_knitr.r

#specifico il percorso di salvataggio dei dati
setwd("D:/lab/")

#richiamo il pacchetto knitr per creare report
library(knitr)

#edito e copio il codie "time series" sulla Groenlandia, lo incollo su un editor di testo e lo salvo come "R_code_greenland.txt"

#utilizzo la funzione stitch per la creazione di report automatici
stitch("R_code_greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#errore: manca il pacchetto tinytex

#installo il pacchetto tinyhtex
install.packages("tinytex")

#ripeto la funzione stitch. Crea un file .tex che però non riesce a compilare.
#risolvo con:
tinytex::install_tinytex()
tinytex::tImgr_update()

#rilancio la funzione stitch e mi crea il pdf richiesto
stitch("R_code_greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#-------------------------------------------------

# 5. R code multivariate analysis

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

#-------------------------------------------------

# 6. R code classification

#R_code_classification.r

#specifico il percorso di salvataggio dei dati
setwd("D:/lab/")

#richiamo il pacchetto raster
library(raster)

#richiamo il pacchetto RStoolbox
library(RStoolbox)

#salvo l'immagine riferita al sole e ai suoi diversi livelli energetici
#utilizzo la funzione brick per importarla in R e la rinomino "so" (solar orbiter)
so<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

#stampo l'immagine in RGB
plotRGB(so, 1, 2, 3, stretch="Lin")

#per classificare tale immagine utilzzo la funzione unsuperClass (unsupervisored classification), con 3 classi. Rinomino soc (solar orbiter classified)
soc<-unsuperClass(so, nClasses=3)

#plot dell'immagine (solo la mappa)
plot(soc$map)

#riclassifico l'immagine con 20 venti classi
soc20<-unsuperClass(so, nClasses=20)

#plot della nuova classificazione (solo mappa)
plot(soc20$map)

#scarico nuova immagine del sole dal sito dell'Esa-Solar Orbiter; la sinomino "sun"
#importo l'immagine in R con la funzione brick
sun<-brick("sun.png")

#classfico l'immagine con 3 classi
sunc<-unsuperClass(sun, nClasses=3)

#stampo l'immagine (solo la mappa)
plot(sunc$map)


#download dell'immagine del Grand Canyon da Landsat per la sua riclassificazione secondo la riflettanza
#importo in R l'immagine
gc<-brick("dolansprings_oli_2013088_canyon_lrg.jpg")

#plot a colori (lineare) dell'immagine
plotRGB(gc, r=1, g=2, b=3, stretch="Lin")

#plot a colori (a istogramma) dell'immagine
plotRGB(gc, r=1, g=2, b=3, stretch="Hist")

#classificazione con due classi
gcc2<-unsuperClass(gc, nClasses=2)

#stampo l'immagine classificata (solo la mappa)
plot(gcc2$map)

#nuova classificazione con 4 classi
gcc4<-unsuperClass(gc, nClasses=4)

#stampo l'immagine classificata (solo la mappa)
plot(gcc4$map)

#-------------------------------------------------

# 7. R code ggplot2

#percorso di salvataggio dati
setwd("D:/lab/")

#richiamo il pacchetto raster
library(raster)

#richiamo il pacchetto RStoolbox
library(RStoolbox)

#installo il pacchetto ggplot2
install.packages(ggplot2)

#richiamo il pacchetto ggplot2
library(ggplot2)

#importo in R l'immagine defor1
defor1<-brick("defor1.jpg")

#stampo a colori l'immagine (B1=NIR, B2=red, B3=green)
plotRGB(defor1, r=1, g=2, b=3. stretch="Lin")

#con la funzione ggRGB stampo l'immagine a colori con l'aggiunta delle coord. spaziali
ggRGB(defor1, r=1, g=2, b=3. stretch="Lin")

#importo in R l'immagine defor2
defor2<-brick("defor2.jpg")

#stampo anche defor2 con la funzione ggRGB
ggRGB(defor2, r=1, g=2, b=3. stretch="Lin")

#con ggplot2 la funzione par non funziona per creare un multiframe delle due immagini
#per farlo utilizzo la funzione grid.arrange (con nrow definisco il n° di righe) del pacchetto gridExtra (da installare)
install.packages("gridExtra")

#richiamo il pacchetto gridExtra
library(gridExtra)

#rinomino le due stampe con p1 e p2
p1<-ggRGB(defor1, r=1, g=2, b=3. stretch="Lin")
p2<-ggRGB(defor2, r=1, g=2, b=3. stretch="Lin")

#stampo p1 e p2
grid.arrange(p1, p2, nrow=2)

#-------------------------------------------------

# 8. R code vegetation indices

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


#worlwide NDVI

#installo il pacchetto raster rasterdiv per visualizzare una serie di indici a scala globale.
#il set di dati di input è il raster copNDVI (Copernicus Long Term) che ha per ogni pixel l'NDVI medio globale calcolato il 21 giugno tra 1999-2007
install.packages("rasterdiv")

#richiamo il pacchetto rasterdiv
library(rasterdiv)

#stampo l'immagine di scala globale
plot(copNDVI)

#con la funzione "reclassify" e l'argomento "cbind" cambio i pixel 253, 254 e 255 relativi all'acqua per essere trasformati in "non-valori" (NA)
#sovrascrivo così il raster copNDVI e lo stampo
copNDVI<-reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

#richiamo il pacchetto rastervis
library(rastervis)

#stampo l'immagine copNDVI con il level plot per capire l'andamento medio dell'indice a scala longitudinale e latitudinale
levelplot(copNDVI)

#------------------------------------------------

# 9. R code land cover

#percorso di salvataggio dati
setwd("D:/lab/")

#richiamo le librerie necessarie
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)

#importo le immagini defor1 e defor2 relative rispettivamente al 1992 e al 2006
defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")

#classifico defor1 con la funzione unsuperClass con 2 classi
d1c<-unsuperClass(defor1, nClasses=2)

#stampo lo mappa di tale classificazione
plot(d1c$map)

#la classe n° 1 è riferita alla foresta tropicale
#la classe n° 2 è relativa alla parte agricola

#classifico defor2 con 2 classi e stampo la mappa
d2c<-unsuperClass(defor2, nClasses=2)
plot(d2c$map)

#la classe n° 1 è riferita alla foresta tropicale
#la classe n° 2 è relativa alla parte agricola

#classifico defor2 in tre classi e stampo la mappa
d2c3<-unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

#la parte agricola viene suddivisa in due classi che evidentemente hanno riflettanze differenti

#con la funzione freq calcolo la frequenza (il numero) di pixel contenuti in ogni classe dell'immagine defor1
freq(d1c$map)

#nella prima classe ci sono 305333 pixel; nella seconda 35959

#calcolo della percentuale di pixel sul totale

#sommo i pixel per ottenere il totale
s1<-305333+35959
s1

#per il calcolo delle proporzioni divido le frequenza per il n° tot. dei pixel
prop1<-freq(d1c$map)/s1
prop1

#ottengo per la prima classe l'89.83% di pixel relativi alla foresta; per la seconda il 10.17% di pixel relativi alle aree agricole

#totale pixel nell'immagine defor2
s2<-342726

#calcolo la proporzione di pixel per classe in defor2
prop2<-freq(d2c$map)/s2
prop2

#ottengo per la prima classe il 52.21% di pixel relativi alla foresta; per la seconda il 47.79% di pixel relativi alle aree agricole

#definisco le tre colonne di una "tabella" riassuntiva
cover<-c("Forest", "Agriculture")
percent_1992<-c(89.93, 10.17)
percent_2006<-c(52.21, 47.79)

#con la funzione data.frame ottengo un dataset riassuntivo. Come argomenti inserisco i nomi delle tre variabili
percentages<-data.frame(cover, percent_1992, percent_2006)
percentages

#con la funzione ggplot faccio un grafico (a barre) per l'immagine defor1.
#sull'asse delle x inserisco la voce cover, mentre su quello delle y percent_1992
p1<-ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white"))

#grafico con ggplot anche per defor2
p2<-ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white"))

#con la funzione grid.arrange stampo insieme i due grafici su una riga
grid.arrange(p1, p2, nrow=1)

#-------------------------------------------------

# 10. R code variability

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


#Day 2

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

#-------------------------------------------------









































































#------------------------------------------------

