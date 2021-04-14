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









































