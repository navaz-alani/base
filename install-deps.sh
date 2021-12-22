#!/bin/bash

# add any dependencies here...
deps=`cat << EOF
xbindkeys
alsa-utils
mpv
xorg-xbacklight
kitty
libxft
libxinerama
noto-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji
ttf-font-awesome
EOF
`
echo "This script installs dependencies for the base config."
echo
printf "Will install the following using pacman\n\t"
echo ${deps} | sed 's/ /\n\t/g' # pretty print the list
printf "Continue? [y/n] "
read continue

case "${continue}" in
  y | yes)
    echo "Proceeding..."
    sudo pacman -S ${deps}
    ;;
  *)
    echo "Aborted"
esac
