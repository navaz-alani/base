# Base Configuration

This repository contains the base configuration for my Arch installation.
It contains some quality of life improvement aliases & scripts, as well as the
essentials (such as `dwm`, `dmenu`).

## Setup

Clone this repository into the `~/.config` directory.
Do not rename it as the name is used in some of the configuration.

After cloning, make sure you have the dependencies installed.
Run `./install-deps.sh` to do so (you will be presented with a list of the
packages which will be installed, and prompted for confirmation).

## Shell Configuration

Add `source ~/.config/base/cfg` to the `.zshrc` (or equivalent) file.
This will augment the `PATH` variable to run the custom scripts from any
working directory.

## X Configuration

Add the line `xbindkeys -f ~/.config/base/.xbindkeysrc` to the `.xinitrc` file.
This will start the hot-key server.

Add the line `exec dwm` at the end of the `.xinitrc` file.
This starts `dwm` when the X server is started.

