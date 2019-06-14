#!/bin/bash

# Title         : grafico_temperaturas.sh
# Description   : Muestra un gráfico ASCII de las temperaturas de un log
# Author        : Veltys
# Date          : 14-06-2019
# Version       : 0.1.0
# Usage         : sudo bash grafico_temperaturas.sh | ./grafico_temperaturas.sh
# Notes         :


## Variables


## Funciones


## Ejecución principal
if [ "$#" -lt 1 ]; then
	echo "Uso: $0 archivo_log"
else
	horas=($(cat $1 | grep -v '^Informe\ diario\ de\ ' | grep -v '^$' | sed -r -e 's/[[:print:]]*([0-9]{2}\:[0-9]{2})\:[0-9]{2}\ CEST[[:print:]]*/\1/'))
	temperaturas=($(cat $1 | grep -v '^Informe\ diario\ de\ ' | grep -v '^$' | sed -r -e 's/[[:print:]]*temp\=([0-9]{2})\.([0-9])[[:print:]]*/\1,\2/'))

	for (( i=0; i<${#horas[@]}; i++ )); do
		echo "${horas[$i]} ➡ ${temperaturas[$i]}"
	done
fi