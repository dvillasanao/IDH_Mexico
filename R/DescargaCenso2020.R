rm(list=ls())
library(tidyverse)

setwd("/.../IDH_municipal")

#********************************************************************************             
#*   Descarga de los microdatos por estado del cuestionario ampliado del        *
#*         Censo Nacional de Población y Vivienda 2020 (INEGI)                  *
#*                                                                              * 
#********************************************************************************
abrevs <- data.frame(cve= sprintf("%02d", as.numeric(1:32)),
                     estado = c("Aguascalientes","Baja California","Baja California Sur","Campeche","Coahuila","Colima","Chiapas",
                                "Chihuahua", "Ciudad de México","Durango","Guanajuato","Guerrero","Hidalgo","Jalisco",
                                "México","Michoacán","Morelos","Nayarit","Nuevo León","Oaxaca","Puebla","Querétaro","Quintana Roo",
                                "San Luis Potosí","Sinaloa","Sonora","Tabasco","Tamaulipas","Tlaxcala","Veracruz","Yucatán","Zacatecas"),
                     abv = c("ags","bc","bcs","cam","coa","col","chs","chh","cdmx","dgo","gto","gro","hgo","jal","mex","mich","mor",
                             "nay","nl","oax","pue","qro","qroo","slp","sin","son","tab","tam","tla","ver","yuc","zac"))

temp<- tempfile()
tokeep <- c("ID_VIV", "ID_PERSONA", "ENT", "MUN", "FACTOR", "SEXO", "EDAD", "ASISTEN", "ESCOLARI", "NIVACAD", "ALFABET", "ESCOACUM", "CONACT", "UPM", "ESTRATO")
options(timeout=100) #El archivo de Oaxaca tarda más que el resto y necesista extender el tiempo de respuesta 

for (i in 1:32){
  download.file(paste0("https://www.inegi.org.mx/contenidos/programas/ccpv/2020/microdatos/Censo2020_CA_", abrevs[i,"abv"],"_csv.zip"), temp)
  #print(paste0("Personas",i,".CSV"))
  doc <- read_csv(unz(temp, print(paste0("Personas",abrevs[i,"cve"],".CSV")))) %>% select(all_of(tokeep))
  doc$ID_VIV <- as.character(doc$ID_VIV)     #algunas variables son de diferente clase
  doc$ID_PERSONA <- as.character(doc$ID_PERSONA)     #algunas variables son de diferente clase
  doc$ENT <- as.character(doc$ENT)  
  assign(paste0("Personas",abrevs[i,"cve"]), doc)
  unlink(temp)
}

base_completa <- bind_rows(mget(ls(pattern = "Personas")))
save(base_completa, file="Base Completa Censo de población y vivienda 2020.Rda")
