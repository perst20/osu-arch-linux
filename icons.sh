#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$(realpath -s "$0")")
cd "$SCRIPT_PATH"

xdg-desktop-menu uninstall wine-extension-osz.desktop 
xdg-desktop-menu uninstall wine-extension-osz2.desktop 
xdg-desktop-menu uninstall wine-extension-osk.desktop 
xdg-desktop-menu uninstall wine-extension-osr.desktop 
xdg-desktop-menu uninstall wine-osu.desktop 

rm -rf "$HOME/.local/share/osu"
mkdir "$HOME/.local/share/osu"

mkdir -p "$HOME/.local/share/icons/"

dimensions_arr=( $(ls ./icons | awk -F '-' '{print $3}' | awk -F '.' '{print $1}') )

for dimensions in "${dimensions_arr[@]}"; do
    mkdir -p "${HOME}/.local/share/icons/hicolor/${dimensions}/apps/"
    cp "./icons/osu-wine-${dimensions}.png" "${HOME}/.local/share/icons/hicolor/${dimensions}/apps/osu-wine.png" || WARN "Couldn't install $dimensions";
    chmod 644 "${HOME}/.local/share/icons/hicolor/${dimensions}/apps/osu-wine.png" || WARN "chmod icons failed";
done


printf """#!/usr/bin/env bash
""" > "$HOME/.local/share/osu/xdg-open-osu.sh"
printf "%q" "${SCRIPT_PATH}" >> "$HOME/.local/share/osu/xdg-open-osu.sh"
printf """/xdg-open-osu.sh \"\$@\"
""" >> "$HOME/.local/share/osu/xdg-open-osu.sh"

printf """#!/usr/bin/env bash
""" > "$HOME/.local/share/osu/launch.sh"
printf "%q" "${SCRIPT_PATH}" >> "$HOME/.local/share/osu/launch.sh"
printf """/launch.sh \"\$@\"
""" >> "$HOME/.local/share/osu/launch.sh"

chmod +x "$HOME/.local/share/osu/launch.sh" "$HOME/.local/share/osu/xdg-open-osu.sh"

chmod +x "${HOME}/.local/share/osu/launch.sh" "${HOME}/.local/share/osu/xdg-open-osu.sh"


echo """[Desktop Entry]
Type=Application
Name=osu!
MimeType=application/x-wine-extension-osk;
Exec=/usr/bin/bash -c '\$HOME/.local/share/osu/xdg-open-osu.sh \"\$@\"' bash %f
NoDisplay=true
StartupNotify=true
Icon=osu-wine""" > wine-extension-osk.desktop

echo """[Desktop Entry]
Type=Application
Name=osu!
MimeType=application/x-wine-extension-osr;
Exec=/usr/bin/bash -c '\$HOME/.local/share/osu/xdg-open-osu.sh \"\$@\"' bash %f
NoDisplay=true
StartupNotify=true
Icon=osu-wine""" > wine-extension-osr.desktop

echo """[Desktop Entry]
Type=Application
Name=osu!
MimeType=application/x-wine-extension-osz;
Exec=/usr/bin/bash -c '\$HOME/.local/share/osu/xdg-open-osu.sh \"\$@\"' bash %f
NoDisplay=true
StartupNotify=true
Icon=osu-wine""" > wine-extension-osz.desktop


echo """[Desktop Entry]
Type=Application
Name=osu!
MimeType=application/x-wine-extension-osz2;
Exec=/usr/bin/bash -c '\$HOME/.local/share/osu/xdg-open-osu.sh \"\$@\"' bash %f
NoDisplay=true
StartupNotify=true
Icon=osu-wine""" > wine-extension-osz2.desktop

echo """[Desktop Entry]
Name=osu!
Type=Application
Categories=Application;Game;
Exec=/usr/bin/bash -c '\$HOME/.local/share/osu/launch.sh'
StartupNotify=true
StartupWMClass=osu!.exe
Icon=osu-wine""" > wine-osu.desktop

chmod +x wine-extension-osz.desktop wine-extension-osz2.desktop wine-extension-osk.desktop wine-extension-osr.desktop wine-osu.desktop

xdg-desktop-menu install wine-extension-osz.desktop 
xdg-desktop-menu install wine-extension-osz2.desktop 
xdg-desktop-menu install wine-extension-osk.desktop 
xdg-desktop-menu install wine-extension-osr.desktop 
xdg-desktop-menu install wine-osu.desktop 
xdg-desktop-menu forceupdate
