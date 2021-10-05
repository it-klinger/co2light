#!/bin/sh
# SPDX-License-Identifier: GPL-2.0

bme=/sys/bus/iio/devices/iio:device0
sgp=/sys/bus/iio/devices/iio:device1

out=/root/voc.out
cycle=60

echo 29000 > ${sgp}/in_resistance_calibbias

printf "# $(date -Iseconds)\n" >> $out
printf "# in_resistance_calibbias: $(cat ${sgp}/in_resistance_calibbias)\n" >> $out
printf "# ts       \ttemp\thumi\tpressure \tresi\tvoc\n" >> $out

while true
do
	ts=$(date +"%F %X")
	temp=$(cat ${bme}/in_temp_input)
	pres=$(cat ${bme}/in_pressure_input)
	humi=$(cat ${bme}/in_humidityrelative_input)

	echo $temp > ${sgp}/out_temp_raw
	echo $humi >  ${sgp}/out_humidityrelative_raw

	resi=$(cat ${sgp}/in_resistance_raw)
	conc=$(cat ${sgp}/in_concentration_input)

	printf "$ts\t$temp\t$humi\t$pres\t$resi\t$conc\n" >> $out

	conc=$(printf "%.0f" $conc)

	if [ $conc -lt 150 ]
	then
		gpioset -mtime -s${cycle} 3 9=1
	elif  [ $conc -lt 300 ]
	then
		gpioset -mtime -s${cycle} 2 19=1
	else
		gpioset -mtime -s${cycle} 2 18=1
	fi
done


