# osu! installer for arch linux
This script installs osu! on your linux.

## Requirements
- Arch-based distribution (btw i already use one)
- Pipewire

## Installation
- Clone repository to directory where you want to install osu
- Launch ./setup.sh in terminal and follow instructions
- Script will request root priveleges to install patched version of wine using pacman. If you use any other distribution or don't want to give root access, you can skip this step and install patched wine yourself

## Uninstall
Run ./uninstall.sh in terminal 

## Tinkering PipeWire for better lattency
By default script sets optimal lattency settings.

### If you use usb dac
...
