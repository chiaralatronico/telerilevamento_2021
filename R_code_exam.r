#R_code_exam.r


#Analisi telerilevata dell'area 

#percorso di salvataggio dati
setwd("D:/Magistrale/1_anno/2_semestre/Tge/esame/")

#richiamo la libreria raster (pacchetto precedentemente installato)
library(raster)

#richiamo il pacchetto rasterVis
library(rasterVis)


#creo un pacchetto contenente entrambe le immagini

#con la funzione list.files creo prima la lista delle immagini
rlist <- list.files(pattern="jpg")
rlist

#con la funzione lapply applico la funzione raster alla lista appena creata
import <- lapply(rlist, raster)
import

#utilizzo la funzione stack per creare il pacchetto delle immagini 
orlando <- stack(import)

#rinomino le immagini
orlando_1986<-orlando$X1_orlando_tm5_1986108
orlando_2014<-orlando$X2_orlando_oli_2014137

#lancio il plot del pacchetto per visualizzare contemporaneamente le immagini
#plot(orlando)  (scala divise colori orrendi)

#creo una nuova palette di colori 
cl<-colorRampPalette(c("black", "dark blue", "purple", "pink", "yellow")) (100) 

#utilizzo la funzione levelplot per fare il plot delle immagini con un'unica legenda
levelplot(orlando, main="Lo sviluppo di Orlando (Florida)", names.attr=c("Orlando nel 1986 (Landsat 5)", "Orlando nel 2014 (Landsat 8)"), col.regions=cl)

#riapplico la funzione levelplot al blocco di immagini per visualizzare solo quella relativa al 1986 e dopo 2014
levelplot(orlando_1986) #o levelplot(orlando_1986, col.regions=cl)
levelplot(orlando_2014)

#per capire l'avanzamento dell'urbanizzazione faccio una differenza algebrica tra l'immagine del 2014 (maggior urb) e quella del 1986 (minor urb.)
orlando_diff<-orlando_2014-orlando_1986

#creo una nuova palette di colori 
cl2<-colorRampPalette(c("blue", "cyan", "ivory","orange", "red")) (100)

#faccio il plot della diff
plot(orlando_diff, col=cl2)

#altro plot ma con la funzione levelplot
levelplot(orlando_diff, col.regions=cl2)

-------------------------

orlando_1986<-brick("orlando_tm5_1986108.jpg")
orlando_2010<-brick("orlando_tm5_2010286.jpg")

o86<-ggRGB(orlando_1986, r=1, g=2, b=3, stretch="lin")
o10<-ggRGB(orlando_2010, r=1, g=2, b=3, stretch="lin")

library(gridExtra)
grid.arrange(o86, o14, nrow=1, top="Sviluppo di Orlando dal 1986 al 2014")

#classifico orlando_1986 con la funzione unsuperClass con 4 classi
o86c<-unsuperClass(orlando_1986, nClasses=4)
#cl<-colorRampPalette(c('brown','blue','green','gray','light green'))(100)
plot(o86c$map, #col=cl)

#non si può fare
#par(mfrow=c(1,2))
#plot(o86)
#plot(o86c$map)

#classifico orlando_2014 con la funzione unsuperClass con 3 classi
o14c<-unsuperClass(orlando_2014, nClasses=3)
#cl<-colorRampPalette(c('brown','blue','green','gray','light green'))(100)

par(mfrow=c(1,2))
plot(o86c$map), #col=cl)
plot(o14c$map), #col=cl)
     
#86: aree urb ma anche prati campi da golf, no boschi
#laghi
     #boschi foreste
     
#14: aree urb ma non solo
     laghi foreste
     
#fai confronto con immagini google earth
     
#con la funzione freq calcolo la frequenza (il numero) di pixel contenuti in ogni classe dell'immagine 86
freq(o86c$map)    
     
     #value  count
#[1,]     1  97041
#[2,]     2  27760
#[3,]     3 220799
    
#sommo i pixel per ottenere il totale
s86<-97041+27760+220799
s86

#per il calcolo delle proporzioni divido le frequenza per il n° tot. dei pixel
prop86<-freq(o86c$map)/s86
prop86

            #value      count
#[1,] 2.893519e-06 0.28078993   28.08% urb
#[2,] 5.787037e-06 0.08032407   8.03% laghi
#[3,] 8.680556e-06 0.63888600   63.89% boschi

#con la funzione freq calcolo la frequenza (il numero) di pixel contenuti in ogni classe dell'immagine 2014
freq(o14c$map)    
     
     #value  count
#[1,]     1 110131
#[2,]     2  35372
#[3,]     3 200097
    
#sommo i pixel per ottenere il totale
s14<-110131+35372+200097
s14

#per il calcolo delle proporzioni divido le frequenza per il n° tot. dei pixel
prop14<-freq(o14c$map)/s14
prop14

            #value     count
#[1,] 2.893519e-06 0.3186661 31.87%
#[2,] 5.787037e-06 0.1023495 10.23%
#[3,] 8.680556e-06 0.5789844 57.90%
     
#definisco le tre colonne di una "tabella" riassuntiva
copertura<-c("Aree urbane/urbanizzate", "Laghi", "Aree forestali")
percent_1986<-c(28.08, 8.03, 63.89)
percent_2014<-c(31.87, 10.23, 57.90)
     
#con la funzione data.frame ottengo un dataset riassuntivo. Come argomenti inserisco i nomi delle tre variabili
percentuali<-data.frame(copertura, percent_1986, percent_2014)
percentuali

#copertura percent_1986 percent_2014
#1 Aree urbane/urbanizzate        28.08        31.87
#2                   Laghi         8.03        10.23
#3          Aree forestali        63.89        57.90
     
#con la funzione ggplot faccio un grafico (a barre) per l'immagine orlando_1986
#sull'asse delle x inserisco la voce copertura, mentre su quello delle y percent_1986
g1 <- ggplot(percentuali, aes(x=copertura, y=percent_1986, color=copertura)) + geom_bar(stat="identity", fill="white")

#grafico con ggplot anche per defor2
g2<-ggplot(percentuali, aes(x=copertura, y=percent_2014, color=copertura) + geom_bar(stat="identity", fill="white")

#con la funzione grid.arrange stampo insieme i due grafici su una riga
grid.arrange(g1, g2, nrow=1)
 












