#R_code_land_cover.r

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



