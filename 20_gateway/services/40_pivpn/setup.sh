#!/bin/bash
set -e # Stop script executing on any error code

cd "$(dirname "$0")"
NETWORK_INTERFACE_RETRIEVE=$(ip -o -4 route show to default | awk '{print $5}')
export NETWORK_INTERFACE="$NETWORK_INTERFACE_RETRIEVE"
envsubst < resources/options.conf.envsubst > resources/options.conf
sudo apt install curl -y
curl -L https://install.pivpn.io | bash /dev/stdin --unattended resources/options.conf
sudo apt purge --autoremove curl -y
sudo rm resources/options.conf