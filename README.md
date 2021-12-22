# Base Configuration

This repository contains the base configuration for my Arch installation.
It contains some quality of life improvement aliases & scripts, as well as the
essentials (such as `dwm`, `dmenu`).

## Setup

Clone this repository into the `~/.config` directory (do so recursively to also
clone the `dwmstat` repository).
Do not rename it as the name is used in some of the configuration.

After cloning, you can install all the dependencies, compile and install the
programs using the `install.sh` script.
You will need to enter the password to install some programs (e.g.\ `dwm`) to
the root level directories.

## Shell Configuration

Add `source ~/.config/base/cfg` to the `.zshrc` (or equivalent) file.
This will augment the `PATH` variable to run the custom scripts from any
working directory.

## X Configuration

The `.xinitrc` file located in this repository will be symlinked to the home
directory where the `startx` command will search for it.

## Notes

* Establish a convention that all scripts in the `scripts` directory which
  begin with `sb_` are for use (not exclusively) with the status bar.
