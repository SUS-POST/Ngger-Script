#!/bin/sh

# Rango de IP de la red (ajusta según tu red)
network="10.0.0"

echo "Escaneando la red: ${network}.0/24"

# Escanea la red
for i in {1..254}; do
    ip="${network}.$i"
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
