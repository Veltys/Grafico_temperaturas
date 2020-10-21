# Grafico_temperaturas

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/e039a4c77e2c4c22b78607ce93413984)](https://app.codacy.com/gh/Veltys/Grafico_temperaturas?utm_source=github.com&utm_medium=referral&utm_content=Veltys/Grafico_temperaturas&utm_campaign=Badge_Grade)

Generador de gráfico de temperaturas para logs de Raspberry Pi

## Descripción
Sistema generador un gráfico de temperaturas a partir de logs de formato personalizado de Raspberry Pi

## Sistemas
- **grafico_temperaturas.sh**: Sistema generador un gráfico de temperaturas a partir de logs de formato personalizado de Raspberry Pi.


## Historial de versiones
- 0.0.1:
    - Versión inicial.
- 0.1.0:
    - Recogida de los valores procedentes del log.
- 0.2.0:
    - Redondeo del vector de temperaturas.
- 0.2.1:
    - Primera prueba de pintada de datos.
- 0.2.2:
    - Ya no es necesaria la impresión de la tabla de vectores de datos.
- 0.2.3:
    - Cálculo del valor máximo del gráfico.
- 0.2.4:
    - Arregladas las comprobaciones al formato de bash.
- 0.3.0:
    - Pintada del cuerpo del gráfico.
- 0.3.1:
    - Arreglo de saltos de línea.
- 0.3.2:
    - Arreglo de variable contadora incorrecta.
- 0.3.3:
    - Homogeneizado de números del eje Y del gráfico.
- 0.4.0:
    - Pintado del eje X del gráfico.
- 0.4.1:
    - Optimización y arreglo de bucles.
- 0.4.2:
    - Separación lateral del eje X.
- 0.4.3:
    - Formato de los números del eje Y.
- 0.5.0:
    - Cambiada la generación del gráfico por otra más clara.
- 0.5.1:
    - Valor mínimo del gráfico.
- 0.6.0:
    - Valor mínimo del gráfico como parámetro.
- 0.7.0:
    - Cálculo del relleno del gráfico.
- 0.7.1:
    - El comando "wc" no cuenta los caracteres como se esperaba.
- 1.0.0:
    - Importación del repositorio a GitHub.
    - Creación de este documento.
- 2.0.0:
    - Opción de pintar una segunda gráfica, para sonda de temperatura.
- 2.0.1:
    - Arreglo en la sangría del script.
- 2.0.2:
    - Añadidos los nuevos parámetros en la descripción del script.
- 2.1.0:
    - Valor mínimo automático y añadido parámetro de offset.
- 2.1.1:
    - Arreglo del valor de offset en todos los casos.
- 2.1.2:
    - Optimizaciones varias.
- 2.1.3:
    - Arreglo de la detección de las horas cuando se está en el horario de invierno.
- 2.1.4:
    - Arreglo de la detección de ciertos números.
- 2.1.5:
    - Arreglo de la detección de la franja horaria (sigue siendo válido para CET / CEST solamente :P).
