#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$(realpath -s "$0")")
cd "$SCRIPT_PATH"

mkdir -p ~/.config/pipewire/pipewire-pulse.conf.d/
cp "${SCRIPT_PATH}/pipewire-patches/99-low-latency.conf" ~/.config/pipewire/pipewire-pulse.conf.d/

mkdir -p ~/.config/wireplumber/main.lua.d/
cp "${SCRIPT_PATH}/pipewire-patches/99-usb-low-latency.lua" ~/.config/wireplumber/main.lua.d/

./restart-pipewire.sh
