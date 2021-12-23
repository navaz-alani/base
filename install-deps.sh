#!/bin/bash

# add any dependencies here...
deps=`cat << EOF
go
dunst
pamixer
inotify-tools
python-pywal
feh
mpv
socat
sxiv
rofi
kitty
xorg-xbacklight xbindkeys xdotool
libxft libxinerama
noto-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji
ttf-font-awesome
EOF
`
printf "==> Will install the following dependencies using pacman\n\t"
echo ${deps} | sed 's/ /\n\t/g' # pretty print the list
printf "==> continue? [y/n] "
read continue

case "${continue}" in
  y | yes)
    echo "Proceeding..."
    ;;
  *)
    echo "Aborted"
    exit 1
esac

sudo pacman -S ${deps}
if [ $? -ne 0 ]; then
  echo "error installing dependencies!"
  exit 1
else
  echo "==> dependencies installed!"
  echo "==> run 'make bootstrap' to bootstrap the system"
fi
