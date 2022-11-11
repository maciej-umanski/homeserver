#!/bin/bash

# shellcheck disable=SC2164
SCRIPT_PATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

sudo apt-get update

sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils \
libguestfs-tools genisoimage virtinst libosinfo-bin -y

sudo usermod -aG libvirt "$USER"
sudo usermod -aG libvirt-qemu "$USER"

sudo virsh net-define --file "$SCRIPT_PATH"/configuration/bridged.xml
sudo virsh net-autostart br0
sudo virsh net-start br0

sudo cp "$SCRIPT_PATH"/configuration/docker-iptables-kvm.service /etc/systemd/system/
sudo systemctl enable docker-iptables-kvm.service