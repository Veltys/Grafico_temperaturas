#!/bin/bash

# Title         : grafico_temperaturas.sh
# Description   : Muestra un gráfico ASCII de las temperaturas de un log
# Author        : Veltys
# Date          : 2019-10-29
# Version       : 2.1.4
# Usage         : sudo bash grafico_temperaturas.sh [ -o offset ] [ -t ] archivo_log | ./grafico_temperaturas.sh [ -o offset ] [ -t ] archivo_log
# Notes         :


## Variables
min_offset=5

## Funciones
redondear() {
	printf "%.${2}f" "${1}"
}

rellenar() {
	for (( k=0; k<${1}; k++ )); do
		echo -n ' '
	done
}

pintar() {
	maximo=0
	minimo=100

	# Cálculo del valor mínimo de la gráfica
	for (( i=0; i<${#temperaturas[@]}; i++ )); do
		temperaturas[$i]=$(redondear ${temperaturas[$i]} 0)

		if [ $minimo -gt ${temperaturas[$i]} ]; then
			minimo=${temperaturas[$i]}
		fi
	done

	if [ "$offset" -eq "-1" ]; then
		offset=$(($minimo - $(redondear $(($minimo / 10)) 0) * 10))
	fi

	if [ "$offset" -lt "$min_offset" ]; then
		offset=$(($offset+$min_offset))
	fi

	minimo=$(($minimo - $offset))

	# Cálculo del valor máximo de la gráfica
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

	relleno=$((${relleno}-1))

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
}


## Ejecución principal
horas=($(cat ${@: -1} | grep -v '^Informe\ diario\ de\ ' | grep -v '^$' | sed -r -e 's/[[:print:]]*([0-9]{2}\:[0-9]{2})\:[0-9]{2}\ CE?T[[:print:]]*/\1/'))

temperaturas=($(cat ${@: -1} | grep -v '^Informe\ diario\ de\ ' | grep -v '^$' | sed -r -e 's/[[:print:]]*temp\=([0-9]{2})\.([0-9])[[:print:]]*/\1,\2/'))

if [ "$#" -eq 1 ]; then
	offset=-1

	pintar
elif [[ "$#" -gt 1  &&  "$#" -lt 5  && ( "$1" == "-t" || "$3" == "-t" ) ]]; then
	if [ "$1" == "-o" ]; then
		offset=$2
	elif [ "$2" == "-o" ]; then
		offset=$3
	else
		offset=-1
	fi

	pintar

	echo
	echo

	temperaturas=($(cat ${@: -1} | grep -v '^Informe\ diario\ de\ ' | grep -v '^$' | sed -r -e 's/[[:print:]]*Temperatura\: ([0-9]{1,2})[[:print:]]*/\1/' | sed -r -e 's/[[:print:]]*Imposible obtener un resultado válido en [0-9]* intentos[[:print:]]*/0/'))

	if [ "$1" == "-o" ]; then
		offset=$2
	elif [ "$2" == "-o" ]; then
		offset=$3
	else
		offset=-1
	fi

	pintar
else
	echo "Uso: $0 [ -o offset ] [ -t ] archivo_log"
	echo "        -o offset"
	echo "              Establece un desplazamiento hacia abajo del valor mínimo de la gráfica"
	echo "        -t"
	echo "              Recoge también los datos de temperatura exterior"
fi
