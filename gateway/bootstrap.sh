#!/bin/bash

set -e # Stop script executing on any error code
cd "$(dirname "$0")"
source .env

# Install missing software
########################################################################################################################
sudo apt install curl git net-tools sqlite3 unbound unzip -y

# Disable MOTD
########################################################################################################################
touch /home/"${USER}"/.hushlogin

# Set static ip
########################################################################################################################
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
return=$(echo -n "$PIHOLE_PASSWORD" | sha256sum | sed 's/\s.*$//')
return=$(echo -n "$return" | sha256sum | sed 's/\s.*$//')
export PIHOLE_PASSWORD_ENCODED="$return"
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

# Configure Unbound
########################################################################################################################
wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints
sudo cp resources/pi-hole.conf /etc/unbound/unbound.conf.d/
sudo cp resources/52-edns.conf /etc/dnsmasq.d/
sudo systemctl disable --now unbound-resolvconf.service
sudo service unbound restart

# Install PiVPN
########################################################################################################################
NETWORK_INTERFACE_RETRIEVE=$(ip -o -4 route show to default | awk '{print $5}')
export NETWORK_INTERFACE="$NETWORK_INTERFACE_RETRIEVE"
envsubst < resources/options.conf.envsubst > resources/options.conf
curl -L https://install.pivpn.io | bash /dev/stdin --unattended resources/options.conf
sudo rm resources/options.conf

# Install Airconnect
########################################################################################################################
git clone https://github.com/philippe44/AirConnect.git --depth 1 resources/.temp/AirConnect
unzip resources/.temp/AirConnect/AirConnect-*.zip -d resources/.temp/bin
sudo mkdir /var/lib/airconnect
sudo cp resources/.temp/bin/aircast-linux-x86_64-static /var/lib/airconnect/
sudo cp resources/airconnect.service /etc/systemd/system/
sudo chmod 744 /var/lib/airconnect/aircast-linux-x86_64-static
sudo chmod 644 /etc/systemd/system/airconnect.service
sudo systemctl enable airconnect.service
sudo service airconnect start
rm -rf resources/.temp

# Reboot server
########################################################################################################################
sudo reboot now