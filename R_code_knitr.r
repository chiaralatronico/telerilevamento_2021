#R_code_knitr.r

#specifico il percorso di salvataggio dei dati
setwd("D:/lab/")

#richiamo il pacchetto knitr per creare report
library(knitr)

#edito e copio il codie "time series" sulla Groenlandia, lo incollo su un editor di testi e lo salvo come "R_code_greenland.txt"

#utilizzo la funzione stitch per la creazione di report automatici
stitch("R_code_greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

#errore: manca il pacchetto tinytex

#installo il pacchetto tinyhtex
install.packages("tinytex")

#ripeto la funzione stitch. Crea un file .tex che però non riesce a compilare.
#risolvo con:
tinytex::install_tinytex()
tinytex::tImgr_update()

#rilancio la funzione stitch e mi crea il pdf richiesto
stitch("R_code_greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

