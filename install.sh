#!/bin/bash

# add any dependencies here...
deps=`cat << EOF
go
dunst
pamixer
inotify-tools
python-pywal
mpv
socat
sxiv
kitty
xorg-xbacklight
xbindkeys
xdotool
libxft libxinerama
noto-fonts noto-fonts-extra noto-fonts-cjk noto-fonts-emoji
ttf-font-awesome
EOF
`
printf "Will install the following dependencies using pacman\n\t"
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
    exit 1
esac

# ===============================
# dwm
# ===============================

echo "==============================="
echo "Compiling dwm..."
pushd dwm
make
if [ $? -ne 0 ]; then
  echo "error compiling dwm!"
  exit 1
fi
printf "Installing dwm (password may be required)...\n"
sudo make install
popd
echo "done"

# ===============================
# dwmstat
# ===============================

echo "==============================="
echo "Compiling and installing dwmstat..."
pushd dwmstat
if [ $? -ne 0 ]; then
  echo "error installing dwmstat (make sure you cloned recursively)"
  exit 1
else
  make install
  popd
fi
echo "done"

# ===============================
# extra setup
# ===============================

echo "==============================="
echo "Linking .xinitrc file to home directory..."
ln ./config/.xinitrc ~
if [ $? -ne 0 ]; then
  echo "error linking .xinitrc file!"
  exit 1
fi
echo "done"

echo "==============================="
echo "setting up sxiv key-handler..."
mkdir -p ../sxiv/exec
ln config/sxiv/key-handler
if [ $? -ne 0 ]; then
  echo "error linking sxiv key-handler!"
  exit 1
fi
echo "done"
