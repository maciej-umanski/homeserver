#!/bin/bash

# Disable MOTD
#######################################################################################################################
echo "Disabling MOTD"
touch "$HOME"/.hushlogin
#######################################################################################################################

# Debloat APT
#######################################################################################################################
tee -a /etc/apt/apt.conf.d/99_norecommends > /dev/null <<EOT
APT::Install-Suggests "0";
APT::Install-Recommends "0";
APT::AutoRemove::RecommendsImportant "0";
APT::AutoRemove::SuggestsImportant "0";
EOT

apt update && apt upgrade -y && apt autoremove -y && apt autoclean -y
#######################################################################################################################

# Enable APT repositories
#######################################################################################################################
cp /etc/apt/sources.list /etc/apt/sources.list.bak
sed -r -i 's/^deb(.*)$/deb\1 contrib non-free/g' /etc/apt/sources.list
apt update
#######################################################################################################################

# Install Docker
#######################################################################################################################
apt update && apt install ca-certificates curl gnupg lsb-release -y

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update && apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y

usermod -aG docker "$USER"
#######################################################################################################################

# Install needed software (hardware specific)
#######################################################################################################################
apt update && apt install openssh-server vim firmware-linux-nonfree amd-microcode -y
#######################################################################################################################
