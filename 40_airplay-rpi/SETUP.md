## Airplay-Rpi setup
Add AirPlay2 support to Panasonic SC-PMX90 stereo system through PC input.

### Hardware
* Raspberry Pi Zero W - DISK: **4GB microSD**

### Services
* System tweaks
    * Disable MOTD.
    * Set default audio device to usb stereo system.
    * Disable energy saving on Wi-Fi card.
    * Install software:
      * git
* Shairport-sync
  * [NQPTP](https://github.com/mikebrady/nqptp)
  * [Shairport-sync](https://github.com/mikebrady/shairport-sync)

### Installation
* Prepare SD card using [rpi-imager](https://github.com/raspberrypi/rpi-imager)
  * Device: **Raspberry Pi Zero**
  * Operating System: **Other -> Raspberry Pi OS (Legacy, 32-bit) Lite**
  * Storage: **microSD card**
  * OS Customisation
    * General
      * Set hostname: **SC-PMX90**
      * Set username and password: **fill accordingly**
      * Configure wireless LAN: 
        * SSID / Password: **fill accordingly**
        * Wireless LAN country: **PL**
      * Set locale settings: 
        * Time zone: **Europe/Warsaw**
        * Keyboard layout: **pl**
    * Services
      * Enable SSH: **enable**
      * Use password authentication: **enable**

* Execute `bootstrap.sh`.