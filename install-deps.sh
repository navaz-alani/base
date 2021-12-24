#!/bin/bash

# add any dependencies here...
pacman_deps=`cat << EOF
xorg-server xorg-xinit xorg-xbacklight
xbindkeys xdotool
libxinerama
noto-fonts noto-fonts-extra noto-fonts-cjk ttf-font-awesome ttf-joypixels
sxiv python-pywal feh
util-linux
go socat
dunst
pamixer
inotify-tools
mpv
rofi
git
EOF
`

aur_deps=`cat << EOF
libxft-bgra
EOF
`

printf "==> Will install the following dependencies using pacman\n\t"
echo ${pacman_deps} | sed 's/ /\n\t/g' # pretty print the list
printf "==> and the following from the AUR\n\t"
echo ${aur_deps} | sed 's/ /\n\t/g' # pretty print the list
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

sudo pacman -Sy # sync repos first
sudo pacman -S ${pacman_deps}
if [ $? -ne 0 ]; then
  echo "==> error installing dependencies!"
  exit 1
else
  echo "==> dependencies installed!"
fi


echo "==> Installing yay AUR helper...\n"
git clone https://aur.archlinux.org/yay-git.git
if [ $? -ne 0 ]; then
  echo "==> error downloading yay"
  exit 1
fi
cd yay-git
makepkg -si
if [ $? -ne 0 ]; then
  echo "==> error installing yay"
  exit 1
fi
printf "==> installed yay; cleaning up..."
cd .. && rm -rf yay-git
printf "\tdone\n"

printf "==> Installing AUR dependencies...\n"
sudo yay -Sy # sync repos first
if [ $? -ne 0 ]; then
  echo "error installing AUR dependencies!"
  exit 1
else
  echo "==> dependencies installed!"
  echo "==> run 'make bootstrap' to bootstrap the system"
fi
sudo yay -S ${aur_deps}
