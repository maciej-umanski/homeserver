#!/bin/bash
set -e # Stop script executing on any error code
cd "$(dirname "$0")"

# Disable MOTD
########################################################################################################################
touch /home/"${USER}"/.hushlogin

# Add No subscription repositories
########################################################################################################################
sed -i -e 's|^deb https://enterprise.proxmox.com/debian/pve bookworm pve-enterprise|#&|' -e '$a\deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription' /etc/apt/sources.list.d/pve-enterprise.list
sed -i -e 's|^deb https://enterprise.proxmox.com/debian/ceph-quincy bookworm enterprise|#&|' -e '$a\deb http://download.proxmox.com/debian/ceph-quincy bookworm no-subscription' /etc/apt/sources.list.d/ceph.list

apt update && apt upgrade -y && apt autoremove -y && apt autoclean -y

# Delete local-lvm and resize local
########################################################################################################################
lvremove /dev/pve/data
lvresize -l +100%FREE /dev/pve/root
resize2fs /dev/mapper/pve-root

# Clear and connect second drive
########################################################################################################################
read -p "Do you want to add second disk? (yes/no): " answer

if [ "$answer" = "yes" ]; then
  read -p "Do you want to clear the disk? (yes/no): " answer1

  if [ "$answer1" = "yes" ]; then
      echo "Clearing the disk..."
      apt install parted -y
      parted /dev/sdb mklabel gpt
      parted -a opt /dev/sdb mkpart primary ext4 0% 100%
      mkfs.ext4 -L data /dev/sdb1
      echo "Disk cleared successfully."
  fi

  mkdir -p /mnt/data
  echo 'LABEL=data /mnt/data ext4 defaults 0 2' | tee -a /etc/fstab
  mount -a
fi

# Install software
########################################################################################################################
apt install avahi-daemon -y
