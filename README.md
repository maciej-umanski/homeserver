# Home server

The home server configuration project is designed to simplify the setup, management, and maintenance of a personal home
server.

### Table of Contents

1. [Zeus](#Zeus)
2. [Charon](#Charon)
3. [Hades](#Hades)
4. [Orpheus](#Orpheus)

## Zeus

TP-Link Archer AX53 Router

* **Configuration**
    * Contact your ISP to change your ip from ipv6 to ipv4.
    * Set Port Forwarding 51820 UDP -> Charon (WireGuard connection)
    * Set DHCP IP Reservation for clients.
    * Configure Dynamic DNS and obtain external domain using TPlink DDNS service.

## Charon

HP T620 - CPU: **AMD GX-217GA**, RAM: **4GB**, DISK: **16GB eMMC**

* **Installation**
    * Perform clean installation of [Debian 12 Bookworm](https://www.debian.org/download.en.html).
    * Execute `bootstrap.sh`.
* **Services**
    * [Pi-hole](https://github.com/pi-hole/pi-hole) - Inserts
      curated [blocking lists](servers/charon/resources/adlists.txt), configured to use Unbound as a DNS resolver.
    * [Unbound](https://nlnetlabs.nl/projects/unbound/about/) - Configured according
      to [pi-hole documentation](https://docs.pi-hole.net/guides/dns/unbound/).
    * [Pivpn](https://github.com/pivpn/pivpn)

## Hades

Lenovo M900 Tiny - CPU: **Intel I5-6500T**, RAM: **16GB**, DISK: **256GB NVME + 480GB SATA SSD**

* **Installation**
    * Perform clean installation
      of [Proxmox Virtual Environment](https://www.proxmox.com/en/downloads/proxmox-virtual-environment)
    * Execute `bootstrap.sh`
* **Configuration**
    * Enable [No subscription repositories](https://pve.proxmox.com/wiki/Package_Repositories).
    * Disable no active subscription notice.
    * Delete local-lvm and resize local.
    * Clear and connect second drive.
* **Services**
    * [openmediavault](https://www.openmediavault.org)
    * [qbittorrent](https://github.com/qbittorrent/qBittorrent/wiki/Running-qBittorrent-without-X-server-(WebUI-only,-systemd-service-set-up,-Ubuntu-15.04-or-newer))
    * [homeassistant](https://www.home-assistant.io)
    * [docker](https://docs.docker.com/engine/install/debian/)
        * [airconnect](https://github.com/1activegeek/docker-airconnect)
        * [iSponsorBlockTV](https://github.com/dmunozv04/iSponsorBlockTV)
        * [ollama](https://ollama.com) + [open-webui](https://openwebui.com)

## Orpheus

Raspberry Pi Zero W - DISK: **4GB microSD**

* **Installation**
    * Prepare SD card using [rpi-imager](https://github.com/raspberrypi/rpi-imager) with Raspberry Pi OS (Legacy, 32-bit) Lite
    * Execute `bootstrap.sh`.
* **Configuration**
    * Set default audio device to usb stereo system.
    * Disable energy saving on Wi-Fi card.
* **Services**
    * [NQPTP](https://github.com/mikebrady/nqptp)
    * [Shairport-sync](https://github.com/mikebrady/shairport-sync)
