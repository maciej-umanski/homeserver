#!/bin/bash
set -e

cd "$(dirname "$0")"

# Set static ip
########################################################################################################################
sudo apt install net-tools -y
INTERFACE=$(ip -o -4 route show to default | awk '{print $5}')
GATEWAY=$(ip -o -4 route show to default | awk '{print $3}')
NETMASK=$(sudo ifconfig | grep -i mask | awk '{print $4}' | head -1)
ADDRESS=$(hostname -I | awk '{print $1}')
sudo mv /etc/network/interfaces /etc/network/interfaces.bak
sudo tee -a /etc/network/interfaces > /dev/null <<EOT
source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto $INTERFACE
iface $INTERFACE inet static
 address $ADDRESS
 netmask $NETMASK
 gateway $GATEWAY
EOT

# Install Pi-hole
########################################################################################################################
sudo apt install sqlite3 curl -y
NETWORK_INTERFACE_RETRIEVE=$(ip -o -4 route show to default | awk '{print $5}')
export NETWORK_INTERFACE="$NETWORK_INTERFACE_RETRIEVE"
envsubst < resources/setupVars.conf.envsubst > resources/setupVars.conf
sudo mkdir /etc/pihole
sudo cp resources/setupVars.conf /etc/pihole/
curl -sSL https://install.pi-hole.net | sudo bash /dev/stdin --unattended
while IFS="" read -r p || [ -n "$p" ]
do
  sudo sqlite3 /etc/pihole/gravity.db "INSERT INTO adlist (address, enabled) VALUES ('$p', 1);"
done < resources/adlists.txt
pihole updateGravity
sudo rm resources/setupVars.conf

# Install Unbound
########################################################################################################################
sudo apt install unbound -y
wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
sudo cp resources/pi-hole.conf /etc/unbound/unbound.conf.d/
sudo cp resources/52-edns.conf /etc/dnsmasq.d/
sudo systemctl disable --now unbound-resolvconf.service
sudo service unbound restart

# Install PiVPN
########################################################################################################################
curl -L https://install.pivpn.io | bash

# Reboot server
########################################################################################################################
sudo reboot now