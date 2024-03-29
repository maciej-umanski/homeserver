#!/bin/bash
set -e # Stop script executing on any error code
cd "$(dirname "$0")"

# Disable MOTD
########################################################################################################################
touch /home/"${USER}"/.hushlogin

# Set static ip
########################################################################################################################
sudo apt install git net-tools -y

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

sudo apt purge --autoremove net-tools -y

# Install software
########################################################################################################################
sudo apt install avahi-daemon -y