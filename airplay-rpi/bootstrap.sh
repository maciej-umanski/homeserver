#!/bin/bash

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

# Install NQPTP
########################################################################################################################
sudo apt install --no-install-recommends build-essential git autoconf automake libtool \
    libpopt-dev libconfig-dev libasound2-dev avahi-daemon libavahi-client-dev libssl-dev libsoxr-dev \
    libplist-dev libsodium-dev libavutil-dev libavcodec-dev libavformat-dev uuid-dev libgcrypt-dev xxd -y
git clone https://github.com/mikebrady/nqptp.git
cd nqptp
autoreconf -fi
./configure --with-systemd-startup
make
sudo make install
sudo systemctl enable nqptp
sudo systemctl start nqptp
cd ..

# Install Shairport-sync
########################################################################################################################
git clone https://github.com/mikebrady/shairport-sync.git
cd shairport-sync
autoreconf -fi
./configure --sysconfdir=/etc --with-alsa --with-soxr --with-avahi --with-ssl=openssl --with-systemd --with-airplay-2
make
sudo make install
sudo sed -i "/\[Service\]/a Restart=always\nRestartSec=3s" /lib/systemd/system/shairport-sync.service
sudo systemctl enable shairport-sync
sudo systemctl start shairport-sync
cd ..
rm -rf nqptp
rm -rf shairport-sync
sudo apt autoremove -y && sudo apt autoclean -y

# Reboot server
########################################################################################################################
sudo reboot now