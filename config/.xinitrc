# maintain single dunst instance
pidof dunst || dunst &
dwmstat & # status bar daemon
xbindkeys -f ~/.config/base/config/.xbindkeysrc
chbg rand # set a random background
exec dwm
