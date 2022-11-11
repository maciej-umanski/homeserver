#!/bin/bash

# shellcheck disable=SC2164
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

sudo cp "$SCRIPT_PATH"/configuration/99_norecommends /etc/apt/apt.conf.d/

sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoclean -y