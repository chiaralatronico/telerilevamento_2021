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










