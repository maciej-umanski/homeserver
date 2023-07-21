#!/bin/bash
set -e # Stop script executing on any error code

USERNAME=$1 # Input variable, account name of logged user

# Disable MOTD
########################################################################################################################
touch /home/"$USERNAME"/.hushlogin

# Enable contrib and non-free APT repositories
########################################################################################################################
cp /etc/apt/sources.list /etc/apt/sources.list.bak
sed -r -i 's/^deb(.*)$/deb\1 contrib non-free/g' /etc/apt/sources.list
apt update

# Debloat APT
########################################################################################################################
tee -a /etc/apt/apt.conf.d/99_norecommends > /dev/null <<EOT
APT::Install-Suggests "0";
APT::Install-Recommends "0";
APT::AutoRemove::RecommendsImportant "0";
APT::AutoRemove::SuggestsImportant "0";
EOT

apt update && apt upgrade -y && apt autoremove -y && apt autoclean -y

# Install hardware specific software from apt
########################################################################################################################
apt install firmware-linux-nonfree amd64-microcode git firmware-realtek net-tools -y

# Install classic software from apt
########################################################################################################################
apt install git net-tools -y

# Install Docker
########################################################################################################################
wget -qO - https://get.docker.com | bash
usermod -aG docker "$USERNAME"

# Set static ip
########################################################################################################################
INTERFACE=$(ip -o -4 route show to default | awk '{print $5}')
GATEWAY=$(ip -o -4 route show to default | awk '{print $3}')
NETMASK=$(ifconfig | grep -i mask | awk '{print $4}' | head -1)
ADDRESS=$(hostname -I | awk '{print $1}')

mv /etc/network/interfaces /etc/network/interfaces.bak

tee -a /etc/network/interfaces > /dev/null <<EOT
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
 dns-nameservers 1.1.1.1 1.0.0.1
EOT

# Reboot server
########################################################################################################################
reboot now