# co2light

Measuring the air quality on Linux with a chemical sensor (e. g. sgp40), 
applying compensation values from temperature and relative humidity sensor (e. g. bme280) and 
set leds appropriately to red, orange or green.

It's just a small shell script with a couple of hard coded values (iio device numbers, gpio numbers). 
Compensation is not necessary for rough measuring, 
but the calibration with the calibbias value (e. g. 29000) is strongly recommended.

References:
linux commit 1081b9d97152e6aa28a1868ec8e0587b2b8fb2ae ("iio: chemical: Add driver support for sgp40")
