#!/bin/bash
set -e # Stop script executing on any error code

cd "$(dirname "$0")"

return=$(echo -n "$PIHOLE_PASSWORD" | sha256sum | sed 's/\s.*$//')
return=$(echo -n "$return" | sha256sum | sed 's/\s.*$//')
export PIHOLE_PASSWORD_ENCODED="$return"

NETWORK_INTERFACE_RETRIEVE=$(ip -o -4 route show to default | awk '{print $5}')
export NETWORK_INTERFACE="$NETWORK_INTERFACE_RETRIEVE"

envsubst < resources/setupVars.conf.envsubst > resources/setupVars.conf
sudo apt install curl sqlite3 -y
sudo mkdir /etc/pihole
sudo cp resources/setupVars.conf /etc/pihole/

curl -sSL https://install.pi-hole.net | sudo bash /dev/stdin --unattended

while IFS="" read -r p || [ -n "$p" ]
do
  sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled) VALUES ('$p', 1);"
done < resources/adlists.txt
pihole updateGravity

sudo apt purge --autoremove curl sqlite3 -y
sudo rm resources/setupVars.conf
