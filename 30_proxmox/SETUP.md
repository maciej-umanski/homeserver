## Gateway setup

### Hardware
* Lenovo M900 Tiny - CPU: **Intel I5-6500T**, RAM: **16GB**, DISK: **120GB+250GB**

### Services
* System tweaks
    * Disable MOTD.
    * [No subscription repositories](https://pve.proxmox.com/wiki/Package_Repositories).
    * Delete local-lvm and resize local.
    * Clear and connect second drive.

### Installation
* Perform clean installation of [Proxmox Virtual Environment](https://www.proxmox.com/en/downloads/proxmox-virtual-environment)
* Execute `bootstrap.sh`.