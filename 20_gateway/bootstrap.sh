#!/bin/bash

set -e # Stop script executing on any error code
cd "$(dirname "$0")"
source .env

# Execute setup scripts
########################################################################################################################
./services/10_system/setup.sh
./services/20_pi-hole/setup.sh
./services/30_unbound/setup.sh
./services/40_pivpn/setup.sh
./services/50_airconnect/setup.sh

# Reboot server
########################################################################################################################
sudo reboot now