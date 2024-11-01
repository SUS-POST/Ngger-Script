#!/bin/sh

# Obtiene la dirección IP local
local_ip=$(ip addr | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | cut -d '/' -f 1)
network="${local_ip%.*}.0/24"

echo "Escaneando la red: $network"

# Escanea la red
for i in {1..254}; do
    ip="${local_ip%.*}.$i"
    if ping -c 1 -W 1 $ip > /dev/null; then
        echo "$ip está activo"

        # Intenta obtener el nombre del dispositivo en $ip
        hostname=$(nslookup $ip | grep 'name =' | awk -F' = ' '{print $2}')
        if echo "$hostname" | grep -iq "roku"; then
            echo "¡Dispositivo Roku encontrado en $ip!"
        fi
    fi
done

echo "Escaneo completo."
