#!/bin/bash

set -e # Stop script executing on any error code
cd "$(dirname "$0")"

# Execute setup scripts
########################################################################################################################

./services/10_system/setup.sh
./services/20_shairport-sync/setup.sh

# Reboot server
########################################################################################################################
sudo reboot now