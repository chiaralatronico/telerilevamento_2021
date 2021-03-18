# Il mio primo codice in R per il telerilevamento

#specifico il percorso di salvataggio della cartella lab (per Windows)
setwd("D:/lab/") 

#inserisco la funzione che richiama il pacchetto raster precedentemente installato con la funzione install.packages("raster")
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
