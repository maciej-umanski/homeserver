#!/bin/bash
set -e # Stop script executing on any error code
cd "$(dirname "$0")"

sudo apt install --no-install-recommends build-essential git autoconf automake libtool \
    libpopt-dev libconfig-dev libasound2-dev avahi-daemon libavahi-client-dev libssl-dev libsoxr-dev \
    libplist-dev libsodium-dev libavutil-dev libavcodec-dev libavformat-dev uuid-dev libgcrypt-dev xxd -y

# NQPTP
git clone https://github.com/mikebrady/nqptp.git
cd nqptp
autoreconf -fi
./configure --with-systemd-startup
make
sudo make install
sudo systemctl enable nqptp
sudo systemctl start nqptp
cd ..

# Shairport-sync
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

# cleanup
rm -rf nqptp
rm -rf shairport-sync
sudo apt autoremove -y && sudo apt autoclean -y