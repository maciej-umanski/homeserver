#!/bin/bash

DISK_PATH=
ISO_PATH=

NAME=debian_$1
DISK_SIZE=10
RAM=1024
CPUS=2

sudo virt-install \
--name "$NAME" \
--hvm \
--ram $RAM \
--disk path="$DISK_PATH"/"$NAME".qcow2,size=$DISK_SIZE,bus=virtio,format=qcow2 \
--vcpus $CPUS \
--os-variant debian10 \
--network=bridge=br0,model=virtio \
--graphics none \
--console pty,target_type=serial \
--location "$ISO_PATH" \
--extra-args 'console=ttyS0,115200n8 serial' \
--noautoconsole