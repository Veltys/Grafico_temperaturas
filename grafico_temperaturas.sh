#!/bin/bash

# Title         : grafico_temperaturas.sh
# Description   : Muestra un gráfico ASCII de las temperaturas de un log
# Author        : Veltys
# Date          : 14-06-2019
# Version       : 0.4.0
# Usage         : sudo bash grafico_temperaturas.sh | ./grafico_temperaturas.sh
# Notes         :


## Variables


## Funciones
redondear() {
  printf "%.${2}f" "${1}"
}

## Ejecución principal
if [ "$#" -lt 1 ]; then
	echo "Uso: $0 archivo_log"
else
	horas=($(cat $1 | grep -v '^Informe\ diario\ de\ ' | grep -v '^$' | sed -r -e 's/[[:print:]]*([0-9]{2}\:[0-9]{2})\:[0-9]{2}\ CEST[[:print:]]*/\1/'))

	temperaturas=($(cat $1 | grep -v '^Informe\ diario\ de\ ' | grep -v '^$' | sed -r -e 's/[[:print:]]*temp\=([0-9]{2})\.([0-9])[[:print:]]*/\1,\2/'))

	maximo=0

	for (( i=0; i<${#temperaturas[@]}; i++ )); do
		temperaturas[$i]=$(redondear ${temperaturas[$i]} 0)

		if [ $maximo -lt ${temperaturas[$i]} ]; then
			maximo=${temperaturas[$i]}
		fi
	done

	for (( i=$maximo; i>=-1; i-- )); do
		if [ $i -gt -1 ]; then
			printf "%-2s | " $i

			for (( j=0; j<${#horas[@]}; j++ )); do
				if [ ${temperaturas[$j]} -ge $i ]; then
					echo -n '== '
				else
					echo -n '   '
				fi
			done

			echo
		else
			echo -n '-----'

			for (( j=0; j<${#horas[@]}; j++ )); do
				echo -n '---'
			done

			echo

			for hora in $horas; do
				echo -n "${hora:0:2} "
			done

			echo

			for hora in $horas; do
				echo -n "${hora:2:2} "
			done

			echo
		fi
	done
fi