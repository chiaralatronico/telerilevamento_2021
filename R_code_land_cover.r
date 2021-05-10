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
