# Base Configuration

This repository contains my Arch/Artix build.
It is set up so that it can bootstrap a bare installation of Arch/Artix (in
general, this should work if `pacman` is available).

## Setup

Clone this repository into the `~/.config` directory (do so recursively to also
clone the `dwmstat` repository).
Do not rename it as the name is used in some of the configuration.

After cloning, you can install all the dependencies, compile and install the
programs using the `install-deps.sh` script.
Now run `make` (or `make bootstrap`, no difference) to compile and install
`dwm` and `dwmstat`, as well as forcefully hard-link some application
configurations into place.

After the `make` step is successfully completed, running `startx` in a TTY
should bring up a graphical environment, the details of which are discussed
later.

## Shell Configuration

Add `source ~/.config/base/cfg` to the `.zshrc` (or equivalent) file.
This will augment the `PATH` variable to make the custom scripts available from
any working directory, as well as source the `aliases` file.

## Specifications

At a high level, this build uses the following major programs

* (patched) `dwm` as the window manager
* (custom) `dwmstat` as the status bar
* (patched) `st` as the terminal emulator
* `rofi` as the application launcher

### [`dwm`](https://dwm.suckless.org)

The `Mod` key for `dwm` is set to the Super (windows) key, because combinations
of the default mod key Alt are used by programs like Firefox.

This `dwm` build has been patched with the following additional functionality
* `xrdb` patch, which allows `dwm` to read colors from the `Xresources` at
  runtime.
  This allows `dwm`'s theme to be changed dynamically e.g. when the background
  is changed (more on this later).
* `gaps` patch, which allows a margin to windows to make the setup more
  visually pleasant.
  Use `Mod+Plus` and `Mod+`
* `shift-tools` patch, which allows shifting through tags and much more.
  See [here](https://dwm.suckless.org/patches/shift-tools/) for more
  information.
* `pertag` patch keeps layout, mwfact (master width factor), barpos (bar
  position) and nmaster (number of master windows) per tag.
* `moveresize` patch which allows moving and resizing floating windows using
  the keyboard.

Here are the major keybindings:

* __Go to tag__: `Mod+[num]` where `num` is the tag number
* __Shift between tags__: `Mod+i` and `Mod+o` shift to the previous and next
  tags respectively 
* __Toggle bar__: `Mod+b` toggles the top bar
* __Window navigation__: Use `Mod+j` and `Mod+k` to navigate windows on a tag.
    Note that this only changes focus, use `Mod+Enter` to swap the focused
    window in the stack and the master window.
* __Kill window__: To kill the program running in a window, run `Mod+Shift+C`.
* __Kill `dwm`__: To kill `dwm` (maybe to test your changes), run
  `Mod+Shift+Q`.
  Note that this will kill all running programs.
* __Layouts__

  * `Mod+t` switches to the tiled layout.
    In this layout, there are two main components: the master window and the
    window stack.
    There is a single master window (this can be changed, but is disabled in
    this build) and the rest of the windows are placed in a window stack which
    appears to the right of the master window.

    Use `Mod+h` and `Mod+l` to reduce and increase the master window's width
    factor respectively.
  * `Mod+f` switches to the floating layout.
    This layout is the default one on MacOS/Windows, and requires manual window
    management, which may be necessary (and more convenient) for some programs
    such as Gimp and Firefox.

    A floating window can be moved around by holding `Mod` and using the mouse
    to click and move it around.
    There are also keybindings for this - which may be considerably faster than
    using the mouse/trackpad.
    In the following keybindings, let `dir` be a direction inputted by the
    arrow keys (`UP`, `DOWN`, `LEFT`, `RIGHT`).

    * Use `Mod+[dir]` to move a floating window around.
    * Use `Mod+Shift+[dir]` to increase/decrease the floating window's
      dimensions.
    * Use `Mod+Ctrl+[dir]` to move the floating window's the maximum amount in
      `dir`.
      For example, `Mod+Ctrl+UP` will move the window so it's top border is at
      the top of the screen.
    * Use `Mod+Ctrl+Shift+[dir]` to increase the window's border the maximum
      amount in direction `dir`.
      For example, `Mod+Ctrl+Shift+DOWN` will move the window's bottom border
      all the way to the bottom of the screen.

  * `Mod+m` switches to the monocle layout.
    This layout stacks the windows on top of each other, master being on the
    top (visible) and the rest being beneath.
    The same keybindings apply to switch between windows as in the tiling
    layout.

* __Move window to tag__: `Mod+Shift+[num]` where `num` is the tag number.
  This moves the selected window to tag `num`.
* __Make window floating__: Focus on a window and press `Mod+Shift+Space` to
  make it floating, while maintaining the tag's layout.
* __Show widow on every tag__: Focus on a window and press `Mod+Shift+0` to
  make it appear on every tag.
  If you want to stop a window from appearing on every tag, explicitly move it
  to a particular tag (`Mod+Shift+[num]`).
  
  __NOTE__: the previous 3 bindings can be used to create a proper
  picture-in-picture window (one that appears on every tag, in  the same
  position).
  Focus on a picture-in-picture window, press `Mod+Shift+Space` to make it
  floating.
  Then, press `Mod+Shift+0` to make it appear on every tag.
  You can then use the keybindings for floating windows to resize/move the
  picture-in-picture window around.

## Misc

### Changing Desktop Background (`chbg`)

By default, when `startx` is run, a new random background is set (`chbg rand`).
A color-scheme (based on the selected background) is generated which, programs
getting their colors from `Xresources` can use.
So `dwm` and `st` will automatically obey this color scheme.

Backgrounds are stored in the `backgrounds` directory.
You can add your own there.

When you run `chbg choose`, a thumbnail list of all the backgrounds in the
backgrounds directory will be brought up in `sxiv`.
You can use `Enter` to maximize a thumbnail and `Enter` again to minimize it.
Vim keys `h, j, k, l` can be used to move around the thumbnail list.
To set an image as the background, focus on its thumbnail and press `Ctrl+x+w`
in quick succession.

### Conventions

* All scripts in the `scripts` directory which begin with `sb_` are for use
  with the status bar.
