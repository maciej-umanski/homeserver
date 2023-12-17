#!/bin/bash
set -e # Stop script executing on any error code

# Download necessary data
cd "$(dirname "$0")"
sudo apt install unzip -y
git clone https://github.com/philippe44/AirConnect.git --depth 1 resources/.temp/AirConnect
unzip resources/.temp/AirConnect/AirConnect-*.zip -d resources/.temp/bin

# Install AirConnect
sudo mkdir /var/lib/airconnect
sudo cp resources/.temp/bin/aircast-linux-x86_64-static /var/lib/airconnect/
sudo cp resources/airconnect.service /etc/systemd/system/
sudo chmod 744 /var/lib/airconnect/aircast-linux-x86_64-static
sudo chmod 644 /etc/systemd/system/airconnect.service
sudo systemctl enable airconnect.service
sudo service airconnect start

# Clean after work
sudo apt purge --autoremove unzip -y
rm -rf resources/.temp