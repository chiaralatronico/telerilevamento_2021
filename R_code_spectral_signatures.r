#R_code_spectral_signatures.r

#richiamo i pacchetti che servono
library(raster)
library(rgdal)
library(ggplot2)

#percorso di salvataggio dati
setwd("D:/lab/")

#importo l'immagine con tutte le bande
defor2<-brick("defor2.jpg")

#conoscere le info dell'immagine, tra le quali le bande
defor2

#le bande si chiamano  defor2.1, defor2.2, defor2.3 e corrispondono a NIR, red, green

#plot dell'immagine
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#differenze di colore più accentuatre dovute alla curva logistica 
plotRGB(defor2, r=1, g=2, b=3, stretch="hist")

#funzione click per creare le firme spettrali. Si clicca sulla mappa per leggere le info relative alla riflettanza
#T= true; type="p": ogni click viene contrassegnato da un punto
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

#posso cliccare sulla mappa sulle parti vegetate (in rosso)
#risultato (esempio sulla foresta):    x     y   cell defor2.1 defor2.2 defor2.3
#                                1 158.5 288.5 135672      197       20       28

# (esempio sul fiume):                 x     y   cell defor2.1 defor2.2 defor2.3
#                                1 120.5 222.5 182956       50       45       52

#chiudo la finestra per uscire dal comando

#tabella riassunta sui valori di riflettanza per bande tra foresta ed acqua
#definisco le variabili (band, forest, water)
band <- c(1,2,3)
forest <- c(197, 20, 28) #inserisco i valori di riflettanza
water <- c(50, 45, 52)

#creo la tab con le tre variabili
spectral_signatures <- data.frame(band, forest, water)
spectral_signatures
#risultato: band forest water
#              1    197    50
#              2     20    45
#              3     28    52

#plot delle firme spettrali (spectral_signatures) per creare un grafico con le variabili 
ggplot(spectral_signatures, aes(x=band)) + 
geom_line(aes(y=forest, color="green"))
#ottengo una linea con i valori di riflettanza di un singolo pixel di foresta nelle tre bande (1,2,3)

#aggiungo la parte relativa all'acqua
ggplot(spectral_signatures, aes(x=band)) + 
geom_line(aes(y=forest, color="green")) +
geom_line(aes(y=water, color="blue"))
#l'acqua ha nel NIR una valore basso perché assorbe del tutto

#con labs aggiungo i nomi degli assi del grafico 
ggplot(spectral_signatures, aes(x=band)) + 
geom_line(aes(y=forest, color="green")) +
geom_line(aes(y=water, color="blue")) +
labs(x="band",y="reflectance")

#importo l'imm. defor1
defor1<-brick("defor1.jpg")

#plot dell'immagine
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")

#firme spettrali dell'immagine defor1
#funzione click per creare le firme spettrali. Si clicca sulla mappa per leggere le info relative alla riflettanza
click(defor1, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

    # x     y   cell defor1.1 defor1.2 defor1.3
#1 47.5 326.5 107862      206       11       28
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 60.5 334.5 102163      206        8       25
 #    x     y   cell defor1.1 defor1.2 defor1.3
#1 82.5 329.5 105755      212       11       29
  #    x     y  cell defor1.1 defor1.2 defor1.3
 #1 81.5 368.5 77908      227       18       39
  #    x     y  cell defor1.1 defor1.2 defor1.3
 #1 94.5 371.5 75779      213       11       33

plotRGB(defor2, r=1, g=2, b=3, stretch="hist")
click(defor2, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")
#prendo 5 punti nella stessa zona di quelli presi nella defor1

     #x     y   cell defor2.1 defor2.2 defor2.3
#1 38.5 318.5 114042      210       17       34
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 58.5 331.5 104741      156      146      136
#     x     y   cell defor2.1 defor2.2 defor2.3
#1 81.5 327.5 107632      177      136      134
 #     x     y  cell defor2.1 defor2.2 defor2.3
 #1 63.5 359.5 84670      155      171      158
 #     x     y  cell defor2.1 defor2.2 defor2.3
 #1 79.5 368.5 78233      212       16       36

#definisco le colonne del grafico
band <- c(1,2,3)
time1 <- c(206, 11, 28) #inserisco i valori di riflettanza
time2 <- c(210, 17, 34)

#creo la tab con le tre variabili
spectral_signatures_temp <- data.frame(band, time1, time2)
spectral_signatures_temp

#risultato: band forest water
#              1    197    50
#              2     20    45
#              3     28    52

#plot delle firme spettrali nel tempo (spectral_signatures_temp) per creare un grafico con le variabili 
ggplot(spectral_signatures_temp, aes(x=band)) + 
geom_line(aes(y=time1, color="red"))+
geom_line(aes(y=time2, color="grey"))+
labs(x="band",y="reflectance")

#definisco le colonne del grafico
#aggiungo i valori relativi a un altro pixel (p2)
band <- c(1,2,3)
time1 <- c(206, 11, 28) #inserisco i valori di riflettanza
time1p2 <- c(206, 8, 25)
time2 <- c(210, 17, 34)
time2p2 <- c(156, 146, 136)

#creo la tab con le variabili
spectral_signatures_temp <- data.frame(band, time1, time2, time1p2, time2p2)
spectral_signatures_temp

#plot delle firme spettrali nel tempo (spectral_signatures_temp) per creare un grafico con le variabili 
ggplot(spectral_signatures_temp, aes(x=band)) + 
geom_line(aes(y=time1, color="red", linetype="dotted"))+
geom_line(aes(y=time1p2, color="red", linetype="dotted"))+
geom_line(aes(y=time2, color="grey", linetype="dotted"))+
geom_line(aes(y=time2p2, color="grey", linetype="dotted"))+
labs(x="band",y="reflectance")


#per generare pt random in un immagine (senza click)
#funzione: random_points o extract

#importo un'immagine dal sito dell'Earth Observatory
eo<-brick("june_puzzler.jpg")

#plot dell'immagine
plotRGB(eo, r=1, g=2, b=3, stretch="lin")

click(eo, id=T, xy=T, cell=T, type="p", pch=16, col="yellow")

      #x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 294.5 271.5 150055             19              8             14
     # x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 308.5 285.5 139989             84            180              0
      #x     y   cell june_puzzler.1 june_puzzler.2 june_puzzler.3
#1 365.5 302.5 127806            201            151             16

#definisco le colonne del grafico
band <- c(1,2,3)
strato1 <- c(19, 8, 14) #inserisco i valori di riflettanza
strato2 <- c(84, 180, 0)
strato3 <- c(201, 151, 16)

#creo la tab con le variabili
spectral_signatures_eo <- data.frame(band, strato1, strato2, strato3)
spectral_signatures_eo

#band strato1 strato2 strato3
#1    1      19      84     201
#2    2       8     180     151
#3    3      14       0      16

ggplot(spectral_signatures_eo, aes(x=band)) + 
geom_line(aes(y=strato1, color="brown"))+
geom_line(aes(y=strato2, color="yellow"))+
geom_line(aes(y=strato3, color="green"))+
labs(x="band",y="reflectance")

#metodo che può servire ad indetificare delle classi


