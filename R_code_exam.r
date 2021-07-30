#R_code_exam.r


#Analisi telerilevata dell'area 

#percorso di salvataggio dati
setwd("D:/Magistrale/1_anno/2_semestre/Tge/esame/")

#richiamo la libreria raster (pacchetto precedentemente installato)
library(raster)

library(RStoolbox)

#richiamo il pacchetto rasterVis
library(rasterVis)

library(gridExtra)

library(ggplot2)


#creo una nuova palette di colori 
#cl<-colorRampPalette(c("black", "dark blue", "purple", "pink", "yellow")) (100) 

#creo una nuova palette di colori 
#cl2<-colorRampPalette(c("blue", "cyan", "ivory","orange", "yellow")) (100)


orlando_1986<-brick("orlando_tm5_1986108.jpg")
orlando_2014<-brick("orlando_oli_2014137.jpg")

#info orlando_1986
#class      : RasterBrick 
#dimensions : 480, 720, 345600, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 720, 0, 480  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : D:/Magistrale/1_anno/2_semestre/Tge/esame/orlando_tm5_1986108.jpg 
#names      : orlando_tm5_1986108.1, orlando_tm5_1986108.2, orlando_tm5_1986108.3 
#min values :                     0,                     0,                     0 
#max values :                   255,                   255,                   255

#info orlando_2014
#class      : RasterBrick 
#dimensions : 480, 720, 345600, 3  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 720, 0, 480  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : D:/Magistrale/1_anno/2_semestre/Tge/esame/orlando_oli_2014137.jpg 
#names      : orlando_oli_2014137.1, orlando_oli_2014137.2, orlando_oli_2014137.3 
#min values :                     0,                     0,                     0 
#max values :                   255,                   255,                   255 


o86<-ggRGB(orlando_1986, r=1, g=2, b=3, stretch="lin")
o14<-ggRGB(orlando_2014, r=1, g=2, b=3, stretch="lin")

grid.arrange(o86, o14, nrow=1, top="Sviluppo di Orlando dal 1986 al 2014")

#classifico orlando_1986 con la funzione unsuperClass con 3 classi
o86c<-unsuperClass(orlando_1986, nClasses=3)

cl<-colorRampPalette(c("#F3E2C2", "#6CCCE0", "#5D8C2E"))(100)

plot(o86c$map, col=cl)

#classifico orlando_2014 con la funzione unsuperClass con 3 classi
o14c<-unsuperClass(orlando_2014, nClasses=3)
plot(o14c$map, col=cl)

par(mfrow=c(1,2))
plot(o86c$map, col=cl)
plot(o14c$map, col=cl)

#1986 e 2014: 
#aree urb ma anche prati campi da golf, no boschi
#laghi
#boschi foreste
     
#fai confronto con immagini google earth
     
#con la funzione freq calcolo la frequenza (il numero) di pixel contenuti in ogni classe dell'immagine 86
freq(o86c$map)    
     
     #value  count
#[1,]     1  105561
#[2,]     2  27521
#[3,]     3 212518

    
#sommo i pixel per ottenere il totale
s86<-105561+27521+212518
s86

#per il calcolo delle proporzioni divido le frequenza per il n° tot. dei pixel
prop86<-freq(o86c$map)/s86
prop86

            #value      count
#[1,] 2.893519e-06 0.30544271  (30.54%)
#[2,] 5.787037e-06 0.07963252   (7.96%)
#[3,] 8.680556e-06 0.61492477  (61.49%)

#con la funzione freq calcolo la frequenza (il numero) di pixel contenuti in ogni classe dell'immagine 2014
freq(o14c$map)    
     
     #value  count
#[1,]     1 110608
#[2,]     2  35108
#[3,]     3 199884
    
#sommo i pixel per ottenere il totale
s14<-110608+35108+199884
s14

#per il calcolo delle proporzioni divido le frequenza per il n° tot. dei pixel
prop14<-freq(o14c$map)/s14
prop14

            #value     count
#[1,] 2.893519e-06 0.3200463  (32.00%)
#[2,] 5.787037e-06 0.1015856  (10.16%)
#[3,] 8.680556e-06 0.5783681  (57.84%)
     
#definisco le tre colonne di una "tabella" riassuntiva
copertura<-c("Aree urbane/urbanizzate", "Specchi d'acqua", "Aree boscate/seminaturali")
percent_1986<-c(30.54, 7.96, 61.49)
percent_2014<-c(32.00, 10.16, 57.84)
     
#con la funzione data.frame ottengo un dataset riassuntivo. Come argomenti inserisco i nomi delle tre variabili
percentuali<-data.frame(copertura, percent_1986, percent_2014)
percentuali

                  #copertura  percent_1986  percent_2014
#1   Aree urbane/urbanizzate         30.54         32.00
#2           Specchi d'acqua          7.96         10.16
#3 Aree boscate/seminaturali         61.49         57.84


#con la funzione ggplot faccio un grafico (a barre) per l'immagine orlando_1986
#sull'asse delle x inserisco la voce copertura, mentre su quello delle y percent_1986
g1 <-ggplot(percentuali, aes(x=copertura, y=percent_1986, fill=copertura)) +
     geom_bar(stat="identity", color="black")+
     geom_text(aes(label=percent_1986), vjust=-0.5, color="black", size=4.5)
G1<-g1 +scale_fill_manual(values=c("#5D8C2E", "#F3E2C2", "#6CCCE0"))+theme(legend.position="top")

#grafico con ggplot anche per defor2
g2 <-ggplot(percentuali, aes(x=copertura, y=percent_2014, fill=copertura)) +
     geom_bar(stat="identity", color="black")+
     geom_text(aes(label=percent_2014), vjust=-0.5, color="black", size=4.5)
G2<-g2 +scale_fill_manual(values=c("#5D8C2E", "#F3E2C2", "#6CCCE0"))+theme(legend.position="top")

#con la funzione grid.arrange stampo insieme i due grafici su una riga
grid.arrange(G1, G2, nrow=1, top="Variazioni della copertura del suolo a Orlando nel 1986 e nel 2014")

--------

#per il calcolo della dev.standard si utilizza la "finestra mobile" (moving window) di un'estensione di tot.pixel x tot.pixel 
#essa passa in una sola banda dell'immagine e calcola di volta in volta la dev.st. dei pixel dell'immagine a cui fa riferimento
#per poterla usare posso calcolare l'ndvi dell'immagine in modo da creare un unico layer su cui calcolare la dev. st.

#rinomino bande 1986
nir86<-orlando_1986$orlando_tm5_1986108.1
red86<-orlando_1986$orlando_tm5_1986108.2

#ndvi 1986
ndvi86<-(nir86-red86)/(nir86+red86)

cln<-colorRampPalette(c('#893660','#E1E6B9','#375D3B'))(100)

#rinomino bande 2014
nir14<-orlando_2014$orlando_oli_2014137.1
red14<-orlando_2014$orlando_oli_2014137.2

#ndvi 2014
ndvi14<-(nir14-red14)/(nir14+red14)

par(mfrow=c(1,2))
plot(ndvi86, col=cln)
plot(ndvi14, col=cln)
dev.off()

diffndvi<-ndvi14-ndvi86
plot(diffndvi, col=cln, main='Differenza di NDVI tra il 2014 e il 1986')
#le zone con differenza di NDVI negativa, ovvero che hanno subito una maggiore perdita di vegetazione, sono in viola

#con la funzione focal calcolo la dev. st. (sd) sull'ndvi con una finestra mobile di 5x5 pixel (w) 
ndvisd89 <- focal(ndvi86, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clsd <- colorRampPalette(c('royal blue','#9AC836','orange','yellow'))(100) 
plot(ndvisd89, col=clsd)

#calcolo la media (è la media della biomassa all'interno dell'immagine)
ndvimean86 <- focal(ndvi86, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
clm <- colorRampPalette(c("#0A3A4A", "#196674", "#33A6B2", "#FEF9D1"))(100) 
#plot della media
plot(ndvimean86, col=clm)
#l'ndvi medio calcolato 

ndvimean14 <- focal(ndvi14, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
plot(ndvimean14, col=clm)

par(mfrow=c(1,2))
plot(ndvimean86, col=clm)
plot(ndvimean14, col=clm)
---------------------------------
plotRGB(orlando_1986)


#funzione click per creare le firme spettrali. Si clicca sulla mappa per leggere le info relative alla riflettanza
#T= true; type="p": ogni click viene contrassegnato da un punto
click(orlando_1986, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

      #x      y   cell  orlando_tm5_1986108.1  orlando_tm5_1986108.2   orlando_tm5_1986108.3
#1 469.5  460.5  14150                    189                     53                      73   #area boscata
      #x      y   cell  orlando_tm5_1986108.1  orlando_tm5_1986108.2   orlando_tm5_1986108.3
#1 659.5  107.5 268500                    210                     97                     101   #area seminaturale


#tabella riassunta sui valori di riflettanza per bande tra foresta ed acqua
#definisco le variabili (banda, area boscata, area seminaturale)
banda <- c(1,2,3)
area_boscata <- c(189, 53, 73) #inserisco i valori di riflettanza
area_seminaturale <- c(210, 97, 101)

#creo la tab con le tre variabili
firme_spettrali <- data.frame(banda, area_boscata, area_seminaturale)
firme_spettrali

   #banda  area_boscata  area_seminaturale
#1     1            189                210
#2     2             53                 97
#3     3             73                101

#plot delle firme spettrali (spectral_signatures) per creare un grafico con le variabili 
p86<-ggplot(firme_spettrali, aes(x=banda)) + 
geom_line(aes(y=area_boscata, color="punto 1")) +
geom_line(aes(y=area_seminaturale, color="punto 2")) +
scale_color_manual(values=c("#E69F00", "#56B4E9"))+
theme(legend.position="top")+
labs(x="banda",y="riflettanza")
p86

plotRGB(orlando_2014)

click(orlando_2014, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

       #x     y  cell  orlando_oli_2014137.1  orlando_oli_2014137.2  orlando_oli_2014137.3
 #1 463.5 454.5 18464                    140                    108                    109  #area urb
      #x     y   cell  orlando_oli_2014137.1  orlando_oli_2014137.2  orlando_oli_2014137.3
#1 659.5 107.5 268500                      0                     48                     58  #specchio d'acqua
                                           

#tabella riassunta sui valori di riflettanza per bande tra foresta ed acqua
#definisco le variabili (banda, area boscata, area seminaturale)
banda <- c(1,2,3)
area_urbanizzata <- c(140, 108, 109) #inserisco i valori di riflettanza
specchio_acqua <- c(0, 48, 58)

#creo la tab con le tre variabili
firme_spettrali14<- data.frame(banda, area_urbanizzata, specchio_acqua)
firme_spettrali14

  #banda area_urbanizzata specchio_acqua
#1     1              140              0
#2     2              108             48
#3     3              109             58

#plot delle firme spettrali per creare un grafico con le variabili 
p14<-ggplot(firme_spettrali, aes(x=banda)) + 
geom_line(aes(y=area_urbanizzata, color="punto 1")) +
geom_line(aes(y=specchio_acqua, color="punto 2")) +
scale_color_manual(values=c("#E69F00", "#56B4E9"))+
theme(legend.position="top")+
labs(x="banda",y="riflettanza")
p14

#grafici uniti
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


tot<- ggplot(firme_spettrali_temp, aes(x=banda)) +                                                                
      geom_line(aes(y=area_boscata, linetype='solid', col="red"))+
      geom_line(aes(y=area_seminaturale, linetype='solid'))+
      geom_line(aes(y=area_urbanizzata, linetype="dotted", col="red"))+
      geom_line(aes(y=specchio_acqua, linetype="dotted"))+
      theme(legend.position="top")+
      labs(x="banda",y="riflettanza")
tot

















