#!/usr/bin/env bash

systemctl --user restart pipewire.service pipewire.socket pipewire-media-session.service pipewire-pulse.service pipewire-pulse.socket
