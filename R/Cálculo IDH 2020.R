rm(list = ls())

# Paquetes utilizados
library(tidyverse)
library(readxl)
library(writexl)
#library(haven)
#library(foreign)

#********************************************************************************             
#*                                                                              * 
#*            CÁLCULO DEL ÍNDICE DE DESARROLLO HUMANO (IDH) 2020                *
#*    Programa de las Naciones Unidas para el Desarrollo (PNUD) en México       *
#*                                                                              * 
#********************************************************************************

# CREAR UN DIRECTORIO 
setwd("/Users/jesuspacheco/Library/CloudStorage/OneDrive-UnitedNationsDevelopmentProgramme/IDH-2020/CÁLCULOS/CÓDIGO PARA PUBLICAR/IDH_municipal")
#setwd("/.../IDH_municipal")


#********************************************************************************
#                Cálculo del subíndice de Educación 2020                       *
#********************************************************************************

## PASO PREVIO 1: RECOLECCIÓN DE DATOS EXTERNOS
#Valores máximos y mínimos de referencia: 
ae_maximo = 18
ape_maximo = 15
#Revisar anexo "Indicadores de referencia IDH"

# CARGAR LA BASE DEL CENSO 
# Se utiliza la base completa de la muestra del Cuestionario Ampliado del Censo
# Consultar el Script "DescargaCenso2020.R", que toma alrededor de 20 min con buena conexión a internet

load("./DatosInsumo/Base Completa Censo de población y vivienda 2020.Rda")

### Paso 1. Generación de nuevas variables, previo a la recodificación
base_educacion <- base_completa %>% mutate(ASISTEN_R=ASISTEN,
                                           ESCOLARI_R=as.numeric(ESCOLARI),
                                           NIVACAD_R=as.numeric(NIVACAD),
                                           ESCOACUM_R=as.numeric(ESCOACUM))

### Paso 2. Recodificación de los años de escolaridad
base_educacion$anios<-NA

base_educacion$anios[base_educacion$NIVACAD_R==0]<-0
base_educacion$anios[base_educacion$NIVACAD_R==1]<-0
base_educacion$anios[base_educacion$NIVACAD_R==2 & base_educacion$ESCOLARI_R==1]<-1
base_educacion$anios[base_educacion$NIVACAD_R==2 & base_educacion$ESCOLARI_R==2]<-2
base_educacion$anios[base_educacion$NIVACAD_R==2 & base_educacion$ESCOLARI_R==3]<-3
base_educacion$anios[base_educacion$NIVACAD_R==2 & base_educacion$ESCOLARI_R==4]<-4
base_educacion$anios[base_educacion$NIVACAD_R==2 & base_educacion$ESCOLARI_R==5]<-5
base_educacion$anios[base_educacion$NIVACAD_R==2 & base_educacion$ESCOLARI_R>5&base_educacion$ESCOLARI_R<99]<-6
base_educacion$anios[base_educacion$NIVACAD_R==3 & base_educacion$ESCOLARI_R==1]<-7
base_educacion$anios[base_educacion$NIVACAD_R==3 & base_educacion$ESCOLARI_R==2]<-8
base_educacion$anios[base_educacion$NIVACAD_R==3 & base_educacion$ESCOLARI_R>2&base_educacion$ESCOLARI_R<99]<-9
base_educacion$anios[base_educacion$NIVACAD_R==4 & base_educacion$ESCOLARI_R==1]<-10
base_educacion$anios[base_educacion$NIVACAD_R==4 & base_educacion$ESCOLARI_R==2]<-11
base_educacion$anios[base_educacion$NIVACAD_R==4 & base_educacion$ESCOLARI_R>2&base_educacion$ESCOLARI_R<99]<-12
base_educacion$anios[base_educacion$NIVACAD_R==5 & base_educacion$ESCOLARI_R==1]<-10
base_educacion$anios[base_educacion$NIVACAD_R==5 & base_educacion$ESCOLARI_R==2]<-11
base_educacion$anios[base_educacion$NIVACAD_R==5 & base_educacion$ESCOLARI_R==3]<-12
base_educacion$anios[base_educacion$NIVACAD_R==5 & base_educacion$ESCOLARI_R>3&base_educacion$ESCOLARI_R<99]<-13
base_educacion$anios[base_educacion$NIVACAD_R==6]<-6
base_educacion$anios[base_educacion$NIVACAD_R==7 & base_educacion$ESCOLARI_R==1]<-10
base_educacion$anios[base_educacion$NIVACAD_R==7 & base_educacion$ESCOLARI_R==2]<-11
base_educacion$anios[base_educacion$NIVACAD_R==7 & base_educacion$ESCOLARI_R==3]<-12
base_educacion$anios[base_educacion$NIVACAD_R==7 & base_educacion$ESCOLARI_R>3&base_educacion$ESCOLARI_R<99]<-13
base_educacion$anios[base_educacion$NIVACAD_R==8 & base_educacion$ESCOLARI_R==1]<-13
base_educacion$anios[base_educacion$NIVACAD_R==8 & base_educacion$ESCOLARI_R==2]<-14
base_educacion$anios[base_educacion$NIVACAD_R==8 & base_educacion$ESCOLARI_R>2&base_educacion$ESCOLARI_R<99]<-15
base_educacion$anios[base_educacion$NIVACAD_R==9 & base_educacion$ESCOLARI_R==1]<-10
base_educacion$anios[base_educacion$NIVACAD_R==9 & base_educacion$ESCOLARI_R==2]<-11
base_educacion$anios[base_educacion$NIVACAD_R==9 & base_educacion$ESCOLARI_R==3]<-12
base_educacion$anios[base_educacion$NIVACAD_R==9 & base_educacion$ESCOLARI_R>3&base_educacion$ESCOLARI_R<99]<-13
base_educacion$anios[base_educacion$NIVACAD_R==10 & base_educacion$ESCOLARI_R==1]<-13
base_educacion$anios[base_educacion$NIVACAD_R==10 & base_educacion$ESCOLARI_R==2]<-14
base_educacion$anios[base_educacion$NIVACAD_R==10 & base_educacion$ESCOLARI_R==3]<-15
base_educacion$anios[base_educacion$NIVACAD_R==10 & base_educacion$ESCOLARI_R>3&base_educacion$ESCOLARI_R<99]<-16
base_educacion$anios[base_educacion$NIVACAD_R==11 & base_educacion$ESCOLARI_R==1]<-13
base_educacion$anios[base_educacion$NIVACAD_R==11 & base_educacion$ESCOLARI_R==2]<-14
base_educacion$anios[base_educacion$NIVACAD_R==11 & base_educacion$ESCOLARI_R==3]<-15
base_educacion$anios[base_educacion$NIVACAD_R==11 & base_educacion$ESCOLARI_R>3&base_educacion$ESCOLARI_R<99]<-16
base_educacion$anios[base_educacion$NIVACAD_R==12 &base_educacion$ESCOLARI_R<99]<-17
base_educacion$anios[base_educacion$NIVACAD_R==13 &base_educacion$ESCOLARI_R==1]<-17
base_educacion$anios[base_educacion$NIVACAD_R==13 &base_educacion$ESCOLARI_R>1&base_educacion$ESCOLARI_R<99]<-18
base_educacion$anios[base_educacion$NIVACAD_R==14 &base_educacion$ESCOLARI_R<99]<-18
base_educacion$anios[base_educacion$ESCOACUM==99]<-99

###Paso 3: Creación de identificadores únicos
base_educacion <- base_educacion %>% mutate(estado = as.numeric(ENT), municipio = as.numeric(MUN), CVEGEO=paste0(ENT, MUN))

## Paso 4 CREACIÓN DEL ÍNDICE DE EDUCACIÓN
### Paso 4a. Creación de los años promedio de escolaridad
base_educacion <- base_educacion %>% mutate(edad_m=ifelse(EDAD==999,NA,EDAD)) %>% 
  mutate(rango_anios=ifelse(anios<99,1,0))

anios_promedio <-base_educacion %>% filter(edad_m>24 & rango_anios==1) %>%  group_by(estado, CVEGEO, municipio) %>% 
  summarise(anios = weighted.mean(anios, FACTOR))

###Paso 4b. Creación de la tasa de matriculación y de los años esperados
base_educacion$asistencia<-NA
base_educacion$asistencia[base_educacion$ASISTEN==1]<-1
base_educacion$asistencia[base_educacion$ASISTEN==3]<-0
base_educacion$asistencia[base_educacion$ASISTEN==9]<-0

base_educacion$rango<-0
base_educacion$rango[base_educacion$EDAD>5 & base_educacion$EDAD<25]<-1
base_educacion$poblacion <- base_educacion$FACTOR
base_educacion$matriculados <- base_educacion$poblacion * base_educacion$asistencia

tasa_matriculacion <- base_educacion %>% filter(rango==1) %>%  group_by(estado, CVEGEO, municipio, EDAD) %>% 
  summarise(poblacion=sum(poblacion, na.rm = T), matriculados = sum(matriculados, na.rm = T)) %>% 
  mutate(tm=matriculados/poblacion) %>% 
  group_by(CVEGEO) %>% mutate(aesperados = sum(tm)) %>% 
  arrange(CVEGEO)

###Paso 4c. Pegado de las bases de datos para generar el índice
base_IE2020<- tasa_matriculacion %>% select(CVEGEO, aesperados) %>%
  unique() %>% inner_join(.,anios_promedio, by="CVEGEO")

###Paso 4d. Creación de los índices
POB20 <- readxl::read_excel("./DatosInsumo/Población 2020.xlsx") %>% 
  mutate(CVEGEO = sprintf("%05d",Clave)) %>% rename(pob20 = poblacion2020) %>%  select(CVEGEO, pob20)

base_IE2020 <- base_IE2020 %>% mutate(IAP=anios/ape_maximo, IAE=aesperados/ae_maximo, IEDU = (IAP+IAE)/2)%>% 
  ungroup() %>% left_join(POB20, by="CVEGEO") %>% rename(AP2020 = anios, 
                                                         AE2020 = aesperados, 
                                                         IE_2020 = IEDU) %>% 
  select(CVEGEO, pob20, AP2020, AE2020, IE_2020)

#writexl::write_xlsx(base_IE2020, "./Resultados/RESULTADOS SE 2020.xlsx")

remove(ae_maximo, ape_maximo)
remove(anios_promedio,tasa_matriculacion, base_completa, base_educacion, POB20)

#********************************************************************************
#                  Cálculo del subíndice de Ingreso 2020                       *
#********************************************************************************
## PASO PREVIO 1: RECOLECCIÓN DE DATOS EXTERNOS
inpc_DIC2015=89.046818
inpc_NOV2020=109.271 
inb20= 22644301.694
ajustePPA = 9.702813

#Valores máximos y mínimos de referencia: 
ing_maximo = 75000
ing_minimo = 100
#Revisar anexo "Indicadores de referencia IDH"

## PASO PREVIO 2: acomodo de las bases de datos
ictpc_20 <- read_excel("DatosInsumo/ICTP2020_CONEVAL.xlsx", skip=1) 
colnames(ictpc_20) <- c("CVE_ENT",
                        "NOM_ENT",
                        "CVEGEO",
                        "NOM_MUN", 
                        "ICTPC20")
ictpc_20 <- ictpc_20 %>% mutate(ICTPC20 = as.numeric(ICTPC20)) 

POB_20 <- read_excel("DatosInsumo/Población 2020.xlsx") %>% mutate(Clave=sprintf("%05d", Clave))
colnames(POB_20) <- c("CVEGEO",
                      "NOM_MUN", 
                      "POB20")

ictpc_20 <- full_join(ictpc_20, POB_20, by="CVEGEO") %>% 
  rename_at(vars(ends_with(".x")), ~str_replace(., "\\..$","")) %>% 
  select_at(vars(-ends_with(".y")))

# 3 MUNICIPIOS NO CUENTAN CON ICTPC CALCULADO POR CONEVAL: 
# 07125 Honduras de la Sierra, CHS
# 29048 La Magdalena Tlaltelulco, TLX
# 04012 Seybaplaya, CAM


######## PASOS SUSTANTIVOS PARA LA CREACIÓN DEL ÍNDICE DE INGRESO 2020 ######## 
## Paso 1. Cambio del ICTPC  a precios de diciembre de 2015 para mantener la comparación de la serie (2010-2020)
ajuste_inpc <- inpc_DIC2015/inpc_NOV2020
ictpc_20 <-  ictpc_20 %>% mutate(ICTP20_15=ICTPC20*ajuste_inpc) %>% 
## Paso 2. Generación del ICTPC anual y ICT por municipio                             
  mutate(ICTPC20_a=ICTP20_15*12,
         ICT2020=ICTPC20_a * POB20)

## Paso 3. Generación del factor de ajuste utilizando el Ingreso Nacional Bruto (INB) 
#El Agregado del Ingreso Corriente Total a nivel nacional: 
ICT20_NACIONAL <- ictpc_20 %>% summarise(sum(ICT2020,na.rm=T)) %>% unlist() %>% unname()
#Mientras que el INB 2020 es:
inb20_def <- inb20 * ajuste_inpc #ajustado a precios de dic2015

#Factor de ajuste del ingreso total
ajuste_inb_20 <- inb20_def*1000000 / ICT20_NACIONAL

## Paso 4. Multiplicar el ICTPC anual, a precios de noviembre de 2020 por el factor de ajuste
ictpc_20 <-  ictpc_20 %>% mutate(ICTPC_ajustado20=ICTPC20_a*ajuste_inb_20) 


## Paso 5. Dividir el ICTPC ajustado entre el Factor de conversión de PPA con respecto al dólar estadounidense, 
ictpc_20 <-  ictpc_20 %>% mutate(ING_PPC20=ICTPC_ajustado20/ajustePPA)

## Paso 6. Crear el índice de Ingreso del IDHM
II_2020 <- ictpc_20 %>% mutate(II_2020=(log(ING_PPC20)-log(ing_minimo))/(log(ing_maximo)-log(ing_minimo)))

base_II2020 <- II_2020 %>% select(CVE_ENT, NOM_ENT, CVEGEO, NOM_MUN, ICTPC20, II_2020, POB20) %>% rename(pob20=POB20)

#write_xlsx(II_2020 , "./Resultados/RESULTADOS SI 2020.xlsx")
remove(ajuste_inb_20, ajuste_inpc, ajustePPA, ICT20_NACIONAL, inb20, inb20_def, ing_maximo, ing_minimo, inpc_DIC2015, inpc_NOV2020)
remove(II_2020, ictpc_20, POB_20)


#********************************************************************************
#                   Cálculo del Subíndice de Salud 2020                         *
#********************************************************************************
## PASO PREVIO 1: #Valores máximos y mínimos de referencia: 
tmi_minima = 1.54 
tmi_maxima = 80.10 

## PASO PREVIO: acomodo de las bases de datos para el cálculo de la Tasa de Mortalidad Infantil (TMI). 
TMI_20<- read_excel("./DatosInsumo/TMI2020_CONAPO.xlsx",sheet = 1) %>% 
  mutate(TMI_2020 = as.numeric(TMI_2020))

# NOTA: Las poblaciones utilizadas para el cálculo de este subíndice corresponden a las estimaciones de CONAPO, 
# que contiene algunas diferencias con respecto a la publicadas por INEGI en el Censo de Población y Vivienda 2020
POB20 <- read_excel("./DatosInsumo/Población 2020 (CONAPO).xlsx") %>% 
  mutate(CVEGEO = sprintf("%05d",CVEGEO)) %>% select(CVEGEO, poblacion2020)

## REGIONALIZACIÓN 
# cálculo de las poblaciones por región en Oaxaca
regs_oax <- read_excel("./DatosInsumo/Regionalizacion_OAX.xlsx") %>% mutate(CVEGEO = sprintf("%05d",CVEGEO))

POB_20regs <- POB20 %>%  mutate(CVE_ENT = substr(CVEGEO, 1,2)) %>% filter(CVE_ENT=="20") %>% 
  left_join(.,regs_oax) %>% group_by(CVE_DIST, NOM_DIST) %>% summarise(poblacion2020 = sum(poblacion2020)) %>% 
  mutate(CVEGEO=as.character(CVE_DIST))

TMI_20 <- left_join(TMI_20, POB20, by = "CVEGEO") %>% rename(POB_2020 = poblacion2020) %>% left_join(.,POB_20regs) %>% 
  mutate(POB_2020 = ifelse(is.na(POB_2020),poblacion2020, POB_2020)) %>% select(-contains("DIST"), -poblacion2020)

######## PASOS SUSTANTIVOS PARA LA CREACIÓN DEL ÍNDICE DE SALUD 2020 ######## 
##Paso 1. Expresar la Tasa de mortalidad infantil (TMI) municipal, en términos de SI
TMI_20$SI_2020 <- 1-(TMI_20$TMI_2020/1000)

##Paso 2. Calcular el máximo y mínimo de Supervivencia Infantil (SI) internacional a partir de las TMI de referencia
TMI_20$SImax <- 1-(tmi_minima/1000)
TMI_20$SImin <- 1-(tmi_maxima/1000)

##Paso 3. Calcular el Índice de Salud
TMI_20 <- TMI_20 %>% mutate(IS_2020=(SI_2020-SImin)/(SImax-SImin))

base_IS2020 <- TMI_20 %>% select(CVE_ENT, CVEGEO, NOM_MUN, TMI_2020, IS_2020)

#write_xlsx(base_IS2020, "./Resultados/RESULTADOS SS 2020.xlsx")

remove(tmi_maxima, tmi_minima)
remove(POB20, POB_20regs, TMI_20)

#********************************************************************************
#                     Cálculo final del IDH 2020                                *
#********************************************************************************

#Dado que los subíndices de ingreso y educación se tienen a nivel municipio en Oxaca, pero el subíndice de salud, 
# únicamente se calculó a nivel distrito, se homologan todos los subíndices a nivel distrito para Oaxaca. 
indices_oax <- full_join(base_II2020,base_IE2020)  %>% filter(CVE_ENT=="20") %>% left_join(.,regs_oax) %>% 
  group_by(CVE_DIST, NOM_DIST) %>% 
  summarise(IE_2020 = weighted.mean(x=IE_2020, w=pob20), 
            II_2020 = weighted.mean(x=II_2020, w=pob20), 
            ICTPC2020 = weighted.mean(x=ICTPC20, w=pob20),
            AP2020     = weighted.mean(x=AP2020, w=pob20),
            AE2020     = weighted.mean(x=AE2020, w=pob20),
            pob20   = sum(pob20)) %>% ungroup() %>% mutate(CVEGEO = as.character(CVE_DIST))


#IDH para el estado de Oaxaca (nivel distritos)
idh_oax <- base_IS2020 %>% filter(CVE_ENT=="20") %>% left_join(indices_oax) %>% select(-CVE_DIST) %>% 
  mutate(IDH_2020 = (IE_2020 * II_2020 * IS_2020)^(1/3)) %>% mutate(NOM_ENT="Oaxaca")
remove(indices_oax)

#IDH para el resto de los estados (nivel municipio)
idh_resto <- full_join(base_II2020, base_IE2020)  %>% left_join(.,base_IS2020) %>% filter(CVE_ENT!="20") %>% 
  mutate(IDH_2020 = (IE_2020 * II_2020 * IS_2020)^(1/3)) %>% rename(ICTPC2020 = ICTPC20)

idh_2020 <- full_join(idh_oax, idh_resto)
remove(idh_oax, idh_resto, regs_oax)

#write_xlsx(idh_2020, "./Resultados/RESULTADOS IDH 2020.xlsx")
