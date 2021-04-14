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

#importo il file scaricato con la funzione raster e gli associo il nome "albedo"
albedo<-raster("c_gls_ALBH_202006130000_GLOBE_PROBAV_V1.5.1.nc")

#specifico una nuova palette di colori
cl <- colorRampPalette(c('light blue','green','red','yellow'))(100)

#stampo l'albedo con la nuova palette di colori
plot(albedo, col=cl)

#ricampionamento bilineare: utilizzo la funzione aggregate per ricampionare (diminuiure il numero di pixel) l'immagine; con l'argomento fact specifico tale diminuizione lineare 
albedores<-aggregate (albedo, fact=100)

#stampo la nuova immagine ricampionata
plot(albedores, col=cl)

#installo il pacchetto knitr
install.packages("knitr")

#installo il pacchetto RStoolbox
install.packages("RStoolbox")
