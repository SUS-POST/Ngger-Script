#!/bin/sh

# Obtiene información de ubicación usando ipinfo.io
location_info=$(curl -s ipinfo.io)

# Extrae la dirección IP, latitud y longitud
local_ip=$(echo $location_info | jq -r '.ip')
latitude=$(echo $location_info | jq -r '.loc' | cut -d ',' -f 1)
longitude=$(echo $location_info | jq -r '.loc' | cut -d ',' -f 2)

# Muestra la información
echo "Dirección IP: $local_ip"
echo "Coordenadas: Latitud: $latitude, Longitud: $longitude"
