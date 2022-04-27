#!/usr/bin/env bash

systemctl --user restart pipewire.service pipewire.socket pipewire-media-session.service pipewire-pulse.service pipewire-pulse.socket wireplumber.service > /dev/null 2> /dev/null
