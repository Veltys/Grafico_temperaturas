#!/bin/bash

# Title         : grafico_temperaturas.sh
# Description   : Muestra un gráfico ASCII de las temperaturas de un log
# Author        : Veltys
# Date          : 14-06-2019
# Version       : 0.7.0
# Usage         : sudo bash grafico_temperaturas.sh | ./grafico_temperaturas.sh
# Notes         :


## Variables
minimo=20


## Funciones
redondear() {
	printf "%.${2}f" "${1}"
}

rellenar() {
	for (( k=0; k<${1}; k++ )); do
		echo -n ' '
	done
}

## Ejecución principal
if [ "$#" -eq 2 ]; then
	minimo=$2
fi

if [ "$#" -lt 1 ]; then
	echo "Uso: $0 archivo_log [minimo]"
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

	relleno=$(echo $maximo | wc -c)

	if [ $(echo $minimo | wc -c) -gt $relleno ]; then
		relleno=$(echo $minimo | wc -c)
	fi

	for (( i=$maximo; i>=${minimo}-1; i-- )); do
		if [[ $i -gt ${minimo}-1 ]]; then
			printf "%0${relleno}d | " $i

			for (( j=0; j<${#horas[@]}; j++ )); do
				if [ ${temperaturas[$j]} -eq $i ]; then
					echo -n '== '
				elif [ ${temperaturas[$j]} -gt $i ]; then
					echo -n '|| '
				else
					echo -n '   '
				fi
			done
		else
			rellenar $(($relleno+1))

			echo -n '--'

			for (( j=0; j<${#horas[@]}-1; j++ )); do
				echo -n '---'
			done

			echo -n '--'

			echo

			rellenar $(($relleno+3))

			for hora in "${horas[@]}"; do
				echo -n "${hora:0:2} "
			done

			echo

			rellenar $(($relleno+3))

			for hora in "${horas[@]}"; do
				echo -n "${hora:3:2} "
			done
		fi

		echo
	done
fi