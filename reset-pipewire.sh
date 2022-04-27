#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$(realpath -s "$0")")
cd "$SCRIPT_PATH"

read -p "Are you sure you want to reset pipewire configuration? <y/N> " prompt
if [[ "$prompt" =~ [yY](es)* ]]
then
  rm -rf ~/.config/pipewire/
  rm -rf ~/.config/wireplumber/
  ./restart-pipewire.sh
  echo "Done."
fi
