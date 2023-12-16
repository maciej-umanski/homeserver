## Gateway setup

### Hardware
* HP T620 - CPU: **AMD GX-217GA**, RAM: **4GB**, DISK: **16GB**

### Services
* System tweaks
  * Disable MOTD.
  * [Debloat APT](https://dennislee.xyz/2020/debian-eliminate-dependency-bloat/).
  * Set static IP from DHCP reservation.
* [Pi-hole](https://github.com/pi-hole/pi-hole)
  * Inserts curated [blocking lists](./services/20_pi-hole/resources/adlists.txt).
  * Configured to use Unbound as a DNS resolver.
* [Unbound](https://nlnetlabs.nl/projects/unbound/about/)
  * Configured according to [pi-hole documentation](https://docs.pi-hole.net/guides/dns/unbound/).
* [Pivpn](https://github.com/pivpn/pivpn)
  * Configured to use Pi-hole as a DNS resolver.
* [Airconnect](https://github.com/philippe44/AirConnect)

### Installation
* Perform clean installation of [Debian 12 Bookworm](https://www.debian.org/download.en.html) with these options:
    * Do not create root account.
    * Select **no additional software** in [tasksel](resources/tasksel.png)
* Install missing software through apt
  ```shell
  sudo apt install openssh-server git -y
  ```
* Execute `cp .env.example .env` and fill the variables in copied file.
* Execute `bootstrap.sh`.