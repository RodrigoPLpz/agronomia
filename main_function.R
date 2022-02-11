# Borrar variables de entorno
#rm(list = ls())

# Verifica entorno de trabajo
getwd()

# Crear ruta si es necesario
# setwd("D:/Skills Depot/agronomia")
# Cargar Bibliotecas
load_lib <- function(){
    library(readr)
    library(readxl)
    library(writexl)
    library(dplyr)
    library(stringr)
    library(ftExtra)
    library(dplyr)
    #library(data.table)
}
load_lib()

# Definir Entradas y Salidas
in_out <- function(){
    # Crear carpetas del proyecto
    # dir.create("input")
    # dir.create("output")
    # dir.create("scripts")
    # Crear las variables globales de salida
    # y entrada
    input  <<- "input"
    output <<- "output"
}
in_out()

# Desactivar notaciÃ³n científicA
options(scipen = 999)

# -------------------------------------- Dataset import ---------------------------------------------------- #
pullIn_data <- function(opc){
    if(opc == "xlsx"){
        pullIn_data_xlsx <<- function(x,y,z,r){
            dts <<- read_xlsx(paste(input,sprintf("%s.xlsx",x), sep = "/"),
                              sheet = z, col_names = TRUE, skip = r)
            dts[dts == "NULL"] <<- NA
            dts <<- dts[order(dts[c(y)]),]
            #dts <<- dts[!duplicated(dts[,c(y)]),]
        }
        # Ejemplo
        # pullIn_data_xlsx("titulo_archivo","titulo_columna que ordena",1,1)
    } else if (opc == "csv"){
        pullIn_data_csv <<- function(x,y){
            dts <<- read.csv(paste(input,sprintf("%s.csv",x), sep = "/"), header = TRUE,
                             stringsAsFactors = FALSE, encoding = "UTF-8")
            dts[dts == "NULL"] <<- NA
            dts <<- dts[order(dts[c(y)]),]
            #dts <<- dts[!duplicated(dts[,c(y)]),]
        }
        # Ejemplo:
        #pullIn_data_csv("titulo_archivo",numero_columna que ordena)
    }
}
# Especificar tipo de dataset: "xlsx" o "csv"
# xlsx: El 3Â° parÃ¡metro se refiere a la pÃ©staÃ±a de la hoja de excel.
#	tambien se puede especificar un nombre "nombrePestaÃ±a".
#       El 4Â° parÃ¡metro especifica el nÃºmero de registros a omitir
# csv: El 2Â° parÃ¡metro especifica el nÃºmero de la columna del dataset
#pullIn_data("csv")
#pullIn_data_xlsx("Device_1","Serial Number",1,1)
#pullIn_data_csv("Device_2",2)
# -------------------------------------- Dataset import ---------------------------------------------------- #

# -------------------------------------- Dataset export ---------------------------------------------------- #
pullOut_data <- function(opc){
    if(opc == "xlsx"){
        pullOut_data_xlsx <<- function(x,y){
            pullOut_data_xlsx <<- function(){
                write_xlsx(x,paste(output,sprintf("%s.xlsx",y), sep = "/"),
                           col_names = TRUE,format_headers = TRUE)
            }
            pullOut_data_xlsx()
        }
        # Ejemplo
        # pullOut_data_xlsx(dts,"device_Rev01")
    } else if (opc == "csv"){
        pullOut_data_csv <<- function (x,y){
            pullOut_data_csv <<- function(){
                write.csv(x,paste(output,sprintf("%s.csv",y),sep = '/'),
                          row.names = FALSE)
            }
            pullOut_data_csv()
        }
        # Ejemplo
        # pullOut_data_csv(dts,"device_Rev02")
    }
}
# Especificar tipo de dataset: "xlsx" o "csv"
# xlsx: Proporcionar variable x (dataset) y var y (tÍtulo del archivo) 
# csv: Proporcionar variable x (dataset) y var y (tÍtulo del archivo) 
#pullOut_data("xlsx")
#pullOut_data_xlsx(dts,"device_Rev03")
# -------------------------------------- Dataset export ---------------------------------------------------- #