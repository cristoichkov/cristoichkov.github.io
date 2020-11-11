## Librerias necesarias
library(dplyr)
library(tidyr)
library(tibble)
library(ggplot2)

#### Cargar las bases de Datos ####
## Cargar la base de datos diametro de tallo 
diam_tallo <- read.table("../data/diametro_tallo.txt", header = TRUE) ## primera fila como encabezados 

## Cargar la base de datos distancia entre costillas
dist_cost <- read.delim("../data/distancia_costillas.txt", skip = 9, sep = ",") ## omitir las primeras 9 lineas y separado por coma

## Cargar la base de datos altura de tallo
alt_tallo <- read.csv("../data/altura_tallo.csv", header = FALSE) ## sin encabezados

## Cambiar el nombre de las columnas de alt_tallo utilizando los encabezados de diam_tallo
colnames(alt_tallo) <- colnames(diam_tallo)

#### Pasar de formato ancho a largo cada base de datos ####
diam_tallo_lar <- diam_tallo %>%
  gather(key = "Localidad", value = "diam") %>%
  rownames_to_column()

dist_cost_lar <- dist_cost %>%
  gather(key = "Localidad", value = "dist_cost") %>%
  rownames_to_column()

alt_tallo_lar <- alt_tallo %>%
  gather(key = "Localidad", value = "alt") %>%
  rownames_to_column()

#### Unir todas las bases de datos
BD_cactus <- left_join(diam_tallo_lar, dist_cost_lar, by = "rowname") %>%
  left_join(., alt_tallo_lar, by = "rowname") %>%
  select(Localidad, diam, dist_cost, alt)

#### Ejercicios con ggplot2 ####  
## 1.- Hacer un grafico de boxplot para la variable diametro de tallo 
## 2.- Rellenas las cajas de color por localidad ###
## 3.- Cambia el nombre de los ejes X (Localidad) y Y (Diámetro (mm)) 
## 4.- Pon titulo (Diagramas de Caja-Bigotes por Localidad para la variable Diámetro)
## 5.- Tamaño del texto del titulo = 24
## 6.- Tamaño del texto del cuadro de leyenda (Titulo y texto = 18)
## 7.- Tamaño del texto de los ejes x y y = 18
## 8.- Guardar la figura en la carpeta out, con dpi = 300,  width = 20 y height = 12