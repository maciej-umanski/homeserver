#!/bin/bash

SOFTWARE_TO_INSTALL=firmware-linux-nonfree intel-microcode firmware-realtek

sudo apt update

sudo apt install "$SOFTWARE_TO_INSTALL" -y