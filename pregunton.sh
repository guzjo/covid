#!/bin/bash

# desarrollado por Israel Aguilar (iaguilaror@gmail.com)
# Para BioFreelancer.com
#Este script pregunta a datos covid para un determinado pais
# 1. Cual ha sido el dia con mas casos nuevos COVID
# 2. A la ultima fecha, cual es el total de fallecimientos

#El primer paso registrar el pais de interes
pais_de_interes="United States"

#Enviar mensaje de inicio
echo "[DEBUG] Analizando datos para $pais_de_interes"

#Filtrar solo datos del pais de interes
grep "$pais_de_interes" owid-covid-data > datos_del_pais.tmp

#Extraemos las columnas de interes
# Se arreglo el bug de espacio en nombres de paises
# se arreglo con el comando tr, introduciendo guion bajo
cut -f 3,4,6 datos_del_pais.tmp | tr " " "_" > columnas.tmp

#Ordenar los datos por la tercera columna
sort -k3 -nr columnas.tmp > ordenados.tmp

## extraer la informacion de la primera fila
head -n1 ordenados.tmp > dia_con_mas_casos.tmp

#Guardar en una variable el dia con mas casos
dia=$(cut -f2 dia_con_mas_casos.tmp)

#Guardar el total de casos nuevos
casos=$(cut -f3 dia_con_mas_casos.tmp)
#variable=$(SUBSHELL)

#Enviar mensajes de resultado
echo "El dia con mas casos en $pais_de_interes fue $dia"
echo "Con un total de $casos casos nuevos"

#Borrar los archivos temporales
rm *.tmp
