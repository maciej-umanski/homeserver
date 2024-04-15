# Home server
* [Router](#Router)
* [Gateway](#Gateway)
* [Proxmox](#Proxmox)
* [AirPlay-Rpi](#Airplay-Rpi)

## Router
TP-Link Archer AX53

### Configuration
* Contact your ISP to change your ip from ipv6 to ipv4.
* Set Port Forwarding 1194 UDP -> Gateway (OpenVPN connection)
* Set DHCP IP Reservation for **Gateway**, **Proxmox** and **RaspberryPi** clients.
* Configure Dynamic DNS and obtain external domain using TPlink DDNS service.

## Gateway
HP T620 - CPU: **AMD GX-217GA**, RAM: **4GB**, DISK: **16GB**

### Services
* Install missing software: `curl git net-tools sqlite3 unbound unzip`
* Disable MOTD.
* Set static IP from DHCP reservation.
* [Pi-hole](https://github.com/pi-hole/pi-hole) - Inserts curated [blocking lists](./services/20_pi-hole/resources/adlists.txt), configured to use Unbound as a DNS resolver.
* [Unbound](https://nlnetlabs.nl/projects/unbound/about/) - Configured according to [pi-hole documentation](https://docs.pi-hole.net/guides/dns/unbound/).
* [Pivpn](https://github.com/pivpn/pivpn) - Configured to use Pi-hole as a DNS resolver.
* [Airconnect](https://github.com/philippe44/AirConnect)

### Configuration
* Perform clean installation of [Debian 12 Bookworm](https://www.debian.org/download.en.html).
* Execute `cp .env.example .env` and fill the variables in copied file.
* Execute `bootstrap.sh`.

## Proxmox
Lenovo M900 Tiny - CPU: **Intel I5-6500T**, RAM: **16GB**, DISK: **120GB+250GB**

### Services
* Disable MOTD.
* Enable [No subscription repositories](https://pve.proxmox.com/wiki/Package_Repositories).
* Delete local-lvm and resize local.
* Clear and connect second drive.

### Configuration
* Perform clean installation of [Proxmox Virtual Environment](https://www.proxmox.com/en/downloads/proxmox-virtual-environment)
* Execute `bootstrap.sh`.

## Airplay-Rpi
Raspberry Pi Zero W - DISK: **4GB microSD**

### Services
* Disable MOTD.
* Set default audio device to usb stereo system.
* Disable energy saving on Wi-Fi card.
* Install [NQPTP](https://github.com/mikebrady/nqptp) and [Shairport-sync](https://github.com/mikebrady/shairport-sync)

### Installation
* Prepare SD card using [rpi-imager](https://github.com/raspberrypi/rpi-imager)
    * Operating System: **Other -> Raspberry Pi OS (Legacy, 32-bit) Lite**
    * Configure Wi-Fi and SSHD access.
* Execute `bootstrap.sh`.