#!/bin/bash
set -e # Stop script executing on any error code
cd "$(dirname "$0")"

# Disable MOTD
########################################################################################################################
touch /home/"${USER}"/.hushlogin

# Update packages
########################################################################################################################
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y

# Set default audio device to usb stereo system
########################################################################################################################
sudo tee -a /etc/asound.conf > /dev/null <<EOT
pcm.!default {
    type hw
    card 1
}

ctl.!default {
    type hw
    card 1
}
EOT

# Disable energy saving on wifi card
########################################################################################################################
sudo iwconfig wlan0 power off
sudo iw dev wlan0 set power_save off
sleep 5