#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$(realpath -s "$0")")
cd "$SCRIPT_PATH"

mkdir -p ~/.config/pipewire/pipewire-pulse.conf.d/
cp "${SCRIPT_PATH}/pipewire-patches/pipewire-pulse-low-latency.conf" ~/.config/pipewire/pipewire-pulse.conf.d/
./restart-pipewire.sh
