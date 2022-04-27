#!/usr/bin/env bash

SCRIPT_PATH=$(dirname "$(realpath -s "$0")")
cd "$SCRIPT_PATH"

#install wine

# TODO: wine-osu filename
if pacman -Qs wine-osu > /dev/null ; then
  read -p "wine-osu is already installed. Reinstall anyway? <y/N> " prompt
  if [[ "$prompt" =~ [yY](es)* ]]
  then
    wget -O 'wine-osu-6.14-1-x86_64.pkg.tar.zst' 'https://drive.google.com/uc?export=download&id=1xgJIe18ccBx6yjPcmBxDbTnS1XxwrAcc'
    sudo pacman -U --noconfirm wine-osu-6.14-1-x86_64.pkg.tar.zst
  fi
else
  echo "wine-osu is not installed"
  wget -O 'wine-osu-6.14-1-x86_64.pkg.tar.zst' 'https://drive.google.com/uc?export=download&id=1xgJIe18ccBx6yjPcmBxDbTnS1XxwrAcc'
  sudo pacman -U --noconfirm wine-osu-6.14-1-x86_64.pkg.tar.zst
fi

if pacman -Qs gamemode > /dev/null ; then
  echo "gamemode is already installed"
else
  echo "gamemode is not installed"
  sudo pacman -S --noconfirm gamemode
fi

if pacman -Qs lib32-gamemode > /dev/null ; then
  echo "lib32-gamemode is already installed"
else
  echo "lib32-gamemode is not installed"
  sudo pacman -S --noconfirm lib32-gamemode
fi

if pacman -Qs winetricks > /dev/null ; then
  echo "winetricks is already installed"
else
  echo "winetricks is not installed"
  sudo pacman -S --noconfirm winetricks
fi

#sudo pacman -U wine-osu-6.14-1-x86_64.pkg.tar.zst

#configure pipewire
# TODO: one file, wireplumber
read -p "do you want to configure pipewire for better latency? <y/N> " prompt
if [[ "$prompt" =~ [yY](es)* ]]
then
  rm -rf ~/.config/pipewire
  cp -rn /usr/share/pipewire ~/.config/pipewire

  patch ~/.config/pipewire/pipewire-pulse.conf < ./pipewire-patches/pipewire-pulse.conf.patch
  patch ~/.config/pipewire/media-session.d/alsa-monitor.conf < ./pipewire-patches/alsa-monitor.conf.patch
fi

#configure prefix
wget 'https://m1.ppy.sh/r/osu!install.exe'
export WINEPREFIX="${SCRIPT_PATH}/prefix"
export PATH="/opt/wine-osu/bin:${PATH}"
mkdir ./prefix
wineboot -u
regedit disable-winemenubuilder.reg
winetricks dotnet48
winetricks meiryo
mkdir -p "./prefix/drive_c/users/$USER/osu"
cp osu\!install.exe "./prefix/drive_c/users/$USER/osu/"
cd "./prefix/drive_c/users/$USER/osu"
wine osu\!install.exe

#setup icons
cd "$SCRIPT_PATH"

./icons.sh

ln -s "$SCRIPT_PATH/prefix/drive_c/users/$USER/osu" ./gamefiles
