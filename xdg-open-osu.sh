#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$(realpath -s "$0")")
cd "$SCRIPT_PATH"

export WINEPREFIX="$SCRIPT_PATH/prefix"
export PATH="/opt/wine-osu/bin:${PATH}"
export vblank_sync=0

gamemoderun wine start /ProgIDOpen osu! "$@"

