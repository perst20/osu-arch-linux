#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$(realpath -s "$0")")
cd "$SCRIPT_PATH"

rm -rf "$HOME/.local/share/osu"
rm -f "$HOME/.local/share/icons/osu.png"

xdg-desktop-menu uninstall wine-extension-osz.desktop 
xdg-desktop-menu uninstall wine-extension-osz2.desktop 
xdg-desktop-menu uninstall wine-extension-osk.desktop 
xdg-desktop-menu uninstall wine-extension-osr.desktop 
xdg-desktop-menu uninstall wine-osu.desktop 
xdg-desktop-menu forceupdate

export WINEPREFIX="$SCRIPT_PATH/prefix"
export PATH="/opt/wine-osu/bin:${PATH}"
wineserver -k
winetricks annihilate
