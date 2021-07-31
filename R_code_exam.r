#R_code_exam.r

#Analisi telerilevata sullo svlippo di Orlando in Florida tra il 1986 e il 2014
#Immagine del 1984 acquisita da Landsat 5; immagine del 2014 acquisita da Landsat 8
#Fonti immagini: Nasa Earth Observatory

#Sommario
#1) classificazione per valori di riflettanza
#2) firme spettrali
#3) calcolo dell'ndvi

#1) classificazione per valori di riflettanza

#specifico il percorso di salvataggio dati
setwd("D:/Magistrale/1_anno/2_semestre/Tge/esame/")

#Tutti i pacchetti sono stati precedentemente installati con install.packages("...")

#richiamo le librerie necessarie per le analisi 
library(raster) 
library(RStoolbox) 
library(rasterVis) 
library(gridExtra)
library(ggplot2)

#importo le immagini (ciascuna con tre bande) e le rinomino
orlando_1986<-brick("orlando_tm5_1986108.jpg")
orlando_2014<-brick("orlando_oli_2014137.jpg")

#info sull'immagine orlando_1986
orlando_1986

#class      : RasterBrick 
#dimensions : 480, 720, 345600, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 720, 0, 480  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : D:/Magistrale/1_anno/2_semestre/Tge/esame/orlando_tm5_1986108.jpg 
#names      : orlando_tm5_1986108.1, orlando_tm5_1986108.2, orlando_tm5_1986108.3 
#min values :                     0,                     0,                     0 
#max values :                   255,                   255,                   255

#info sull'immagine orlando_2014
orlando_2014

#class      : RasterBrick 
#dimensions : 480, 720, 345600, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 720, 0, 480  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : D:/Magistrale/1_anno/2_semestre/Tge/esame/orlando_oli_2014137.jpg 
#names      : orlando_oli_2014137.1, orlando_oli_2014137.2, orlando_oli_2014137.3 
#min values :                     0,                     0,                     0 
#max values :                   255,                   255,                   255 

#tre bande ciascuna: Banda 1 = NIR, Banda 2 = red, Banda 3 = green
#entrambe immagini a 8 bit con valori da 0 a 255

#stampo le immagini a falsi colori montando il NIR sulla componente red, il red sulla componente green e il green sulla componente blue
o86<-ggRGB(orlando_1986, r=1, g=2, b=3, stretch="lin")
o14<-ggRGB(orlando_2014, r=1, g=2, b=3, stretch="lin")

#metto insieme i plot su una sola riga e assegno un titolo
grid.arrange(o86, o14, nrow=1, top="Sviluppo di Orlando dal 1986 al 2014")

#si nota prevalentemente l'acqua in nero, la vegetazione in tonalità di rosso e l'urbano in toanlità di grigio

#classifico orlando_1986 in 3 classi con la funzione unsuperClass
o86c<-unsuperClass(orlando_1986, nClasses=3)

#classifico orlando_2014 in 3 classi con la funzione unsuperClass 
o14c<-unsuperClass(orlando_2014, nClasses=3)

#creo una nuova palette di colori
cl<-colorRampPalette(c("#F3E2C2", "#6CCCE0", "#5D8C2E"))(100)

#creo un multiframe su una riga e due colonne per stampare le mappe della classificazione
par(mfrow=c(1,2))
plot(o86c$map, col=cl)
plot(o14c$map, col=cl)

#si notano le seguenti classi:
#in chiaro le aree urbane/urbanizzate;
#in celeste gli specchi d'acqua
#in verde le aree vegetate
 
#con la funzione freq calcolo la frequenza (il numero) di pixel contenuti in ogni classe dell'immagine del 1986
freq(o86c$map)    
     
     #value  count
#[1,]     1  105561
#[2,]     2  27521
#[3,]     3 212518

#sommo i pixel per ottenere il totale
s86<-105561+27521+212518

#per il calcolo delle proporzioni divido le frequenza per il n° tot. dei pixel
prop86<-freq(o86c$map)/s86
prop86

            #value      count
#[1,] 2.893519e-06 0.30544271  (il 30.54% dei pixel è relativo alle aree urbane/urbanizzate)
#[2,] 5.787037e-06 0.07963252  (il 7.96% dei pixel è relativo agli specchi d'acqua)
#[3,] 8.680556e-06 0.61492477  (il 61.49% dei pixel è relativo alle aree vegetate)

#con la funzione freq calcolo la frequenza (il numero) di pixel contenuti in ogni classe dell'immagine 2014
freq(o14c$map)    
     
     #value  count
#[1,]     1 110608
#[2,]     2  35108
#[3,]     3 199884
    
#sommo i pixel per ottenere il totale
s14<-110608+35108+199884

#per il calcolo delle proporzioni divido le frequenza per il n° tot. dei pixel
prop14<-freq(o14c$map)/s14
prop14

            #value     count
#[1,] 2.893519e-06 0.3200463  (il 32.00% dei pixel è relativo alle aree urbane/urbanizzate)
#[2,] 5.787037e-06 0.1015856  (il 10.16% dei pixel è relativo agli specchi d'acqua)
#[3,] 8.680556e-06 0.5783681  (il 57.84% dei pixel è relativo alle aree vegetate)
     
#definisco le tre colonne del grafico
copertura<-c("Aree urbane/urbanizzate", "Specchi d'acqua", "Aree boscate/seminaturali")

#inserisco le percentuali di ogni categoria di copertura per entrambe le immagini
percent_1986<-c(30.54, 7.96, 61.49)
percent_2014<-c(32.00, 10.16, 57.84)
     
#con la funzione data.frame ottengo un dataset riassuntivo
percentuali<-data.frame(copertura, percent_1986, percent_2014)
percentuali

                  #copertura  percent_1986  percent_2014
#1   Aree urbane/urbanizzate         30.54         32.00
#2           Specchi d'acqua          7.96         10.16
#3 Aree boscate/seminaturali         61.49         57.84

#con la funzione ggplot faccio un grafico (a barre) per l'immagine orlando_1986
#sull'asse delle x inserisco la voce copertura, mentre su quello delle y percent_1986
#scelgo manualmente i colori da associare alle colonne del grafico
g1 <-ggplot(percentuali, aes(x=copertura, y=percent_1986, fill=copertura)) +
     geom_bar(stat="identity", color="black")+
     geom_text(aes(label=percent_1986), vjust=-0.5, color="black", size=4.5)
G1<-g1 +scale_fill_manual(values=c("#5D8C2E", "#F3E2C2", "#6CCCE0"))+theme(legend.position="top")

#grafico a barre anche per l'immagine orlando_2014
g2 <-ggplot(percentuali, aes(x=copertura, y=percent_2014, fill=copertura)) +
     geom_bar(stat="identity", color="black")+
     geom_text(aes(label=percent_2014), vjust=-0.5, color="black", size=4.5)
G2<-g2 +scale_fill_manual(values=c("#5D8C2E", "#F3E2C2", "#6CCCE0"))+theme(legend.position="top")

#con la funzione grid.arrange stampo insieme i due grafici su una riga e assegno un titolo
grid.arrange(G1, G2, nrow=1, top="Variazioni della copertura del suolo a Orlando nel 1986 e nel 2014")

#--------------------

#2) firme spettrali

#plot dell'immagine del 1986 (a falsi colori: se non specificato, le bande 1, 2 e 3 sono montate rispettivamente sulle componenti RGB) 
plotRGB(orlando_1986)

#con la funzione click clicco su due punti signficativi sulla mappa per leggerne le i valori di riflettanza nelle tre bande
#ogni click viene contrassegnato da un punto giallo con relativo numero
click(orlando_1986, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#punto 1: area boscata 
#punto 2: area seminaturale in prossimità della strada "Florida's Turnpike" 

#leggo i valori di riflettanza

      #x      y   cell  orlando_tm5_1986108.1  orlando_tm5_1986108.2   orlando_tm5_1986108.3
#1 469.5  460.5  14150                    189                     53                      73   
      #x      y   cell  orlando_tm5_1986108.1  orlando_tm5_1986108.2   orlando_tm5_1986108.3
#1 659.5  107.5 268500                    210                     97                     101   


#per avere una tabella riassuntiva dei valori di riflettanza, specifico le variabili: le tre bande e le due coperure 
#definisco le variabili (banda, area boscata, area seminaturale)
banda <- c(1,2,3)
area_boscata <- c(189, 53, 73) #inserisco i valori di riflettanza
area_seminaturale <- c(210, 97, 101) #inserisco i valori di riflettanza

#creo la tab con le tre variabili
firme_spettrali <- data.frame(banda, area_boscata, area_seminaturale)
firme_spettrali

   #banda  area_boscata  area_seminaturale
#1     1            189                210
#2     2             53                 97
#3     3             73                101

#plot delle firme spettrali per creare un grafico lineare sui valori di riflettanza nelle tre bande dei due punti considerati
p86<-ggplot(firme_spettrali, aes(x=banda)) + 
geom_line(aes(y=area_boscata, color="punto 1")) +
geom_line(aes(y=area_seminaturale, color="punto 2")) +
scale_color_manual(values=c("#E69F00", "#56B4E9"))+
theme(legend.position="top")+
labs(x="banda",y="riflettanza")
p86

#ripeto il procedimento per l'immagine del 2014

plotRGB(orlando_2014)

#scelgo gli stessi punti individuati sull'immagine del 1986
#punto 1: area boscata (1986) ora diventata area uranizzata (2014)
#punto 2: area seminaturale (1986) ora diventata lago artificiale (2014)

click(orlando_2014, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

       #x     y  cell  orlando_oli_2014137.1  orlando_oli_2014137.2  orlando_oli_2014137.3
 #1 463.5 454.5 18464                    140                    108                    109  #area urbanizzata
      #x     y   cell  orlando_oli_2014137.1  orlando_oli_2014137.2  orlando_oli_2014137.3
#1 659.5 107.5 268500                      0                     48                     58  #specchio d'acqua
                                           
#definisco le nuove variabili (banda, area urbanizzata, specchio d'acqua)
banda <- c(1,2,3)
area_urbanizzata <- c(140, 108, 109) #inserisco i valori di riflettanza
specchio_acqua <- c(0, 48, 58)  #inserisco i valori di riflettanza

#creo la tab con le tre variabili
firme_spettrali14<- data.frame(banda, area_urbanizzata, specchio_acqua)
firme_spettrali14

  #banda area_urbanizzata specchio_acqua
#1     1              140              0
#2     2              108             48
#3     3              109             58

#plot delle firme spettrali per creare un grafico lineare sui nuovi valori di riflettanza dei soliti due punti considerati
p14<-ggplot(firme_spettrali, aes(x=banda)) + 
geom_line(aes(y=area_urbanizzata, color="punto 1")) +
geom_line(aes(y=specchio_acqua, color="punto 2")) +
scale_color_manual(values=c("#E69F00", "#56B4E9"))+
theme(legend.position="top")+
labs(x="banda",y="riflettanza")
p14

#creo un unico grafico con i quattro punti
banda <- c(1,2,3)
area_boscata<-c(189, 53, 73)
area_seminaturale <- c(210, 97, 101)
area_urbanizzata <- c(140, 108, 109) 
specchio_acqua <- c(0, 48, 58)

#creo la tab con le tre variabili
firme_spettrali_temp<- data.frame(banda, area_boscata, area_seminaturale, area_urbanizzata, specchio_acqua)
firme_spettrali_temp

  #banda  area_boscata area_seminaturale area_urbanizzata specchio_acqua
#1     1           189               210              140              0
#2     2            53                97              108             48
#3     3            73               101              109             58

#plot delle quattro firme spettrali
tot<- ggplot(firme_spettrali_temp, aes(x=banda)) +                                                                
      geom_line(aes(y=area_boscata, linetype='solid', col="red"))+
      geom_line(aes(y=area_seminaturale, linetype='solid'))+
      geom_line(aes(y=area_urbanizzata, linetype="dotted", col="red"))+
      geom_line(aes(y=specchio_acqua, linetype="dotted"))+
      theme(legend.position="top")+
      labs(x="banda",y="riflettanza")
tot

#--------------------

#3) calcolo dell'ndvi (per immagini a stessa risoluzione radiometrica come queste, si può calcolare il dvi)

#per il calcolo della dev.standard si utilizza la "finestra mobile" (moving window) di un'estensione di tot.pixel x tot.pixel 
#essa passa in una sola banda dell'immagine e calcola di volta in volta la dev.st. dei pixel dell'immagine a cui fa riferimento
#per poterla usare posso calcolare l'ndvi dell'immagine in modo da creare un unico layer su cui calcolare la dev. st.

#rinomino le bande del NIR e del red dell'immagine del 1986
nir86<-orlando_1986$orlando_tm5_1986108.1
red86<-orlando_1986$orlando_tm5_1986108.2

#calcolo l'ndvi del 1986
ndvi86<-(nir86-red86)/(nir86+red86)

#rinomino le bande del NIR e del red dell'immagine del 2014
nir14<-orlando_2014$orlando_oli_2014137.1
red14<-orlando_2014$orlando_oli_2014137.2

#calcolo l'ndvi del 2014
ndvi14<-(nir14-red14)/(nir14+red14)

#definisco una palette di colori
cln<-colorRampPalette(c('#893660','#E1E6B9','#375D3B'))(100)

#multiframe per plottare i due ndvi contemporaneamente 
par(mfrow=c(1,2))
plot(ndvi86, col=cln)
plot(ndvi14, col=cln)
dev.off()

#calcolo la differenza tra i due indici 
diffndvi<-ndvi14-ndvi86

#plot della differenza
plot(diffndvi, col=cln, main='Differenza di NDVI tra il 2014 e il 1986')

#i valori positivi mi indicano valori di ndvi maggiori nel 2014
#i valori negativi mi indicano valori di ndvi maggiori nel 1986
#quindi le zone con differenza di NDVI negativa hanno subito una maggiore perdita di vegetazione e sono in viola

#con la funzione focal calcolo la media della biomassa sull'ndvi del 1986 con una finestra mobile di 5x5 pixel
ndvimean86 <- focal(ndvi86, w=matrix(1/9, nrow=3, ncol=3), fun=mean)

#calcolo la media della biomassa sull'ndvi del 2014 con una finestra mobile di 5x5 pixel
ndvimean14 <- focal(ndvi14, w=matrix(1/9, nrow=3, ncol=3), fun=mean)

#cambio palette di colori
clm <- colorRampPalette(c("#0A3A4A", "#196674", "#33A6B2", "#FEF9D1"))(100) 

#multiframe per un plot contemporaneo delle due medie
par(mfrow=c(1,2))
plot(ndvimean86, col=clm)
plot(ndvimean14, col=clm)
