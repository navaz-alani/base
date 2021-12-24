if [ -z "${SESS_UUID}" ]; then
  export SESS_UUID="`uuidgen`"
fi

# maintain single dunst instance
pidof dunst || dunst &

# If `startx` is being run again in the same TTY (e.g. when testing out dwm),
# this will ensure that dwmstat uses the same socket.
#
# This make sure that if `startx` is being run in separate TTYs, then when a
# dwmstat instance is killed after one of the TTY's graphical environment is
# exited (by killing dwm), it does not tear down the other's signalling socket.

# these 2 variables will always be present in a graphical context
export DWMSTAT_PID_FILE="/tmp/dwmstat_pid_${SESS_UUID}"
export DWMSTAT_SOCK="/tmp/dwmstat_sock_${SESS_UUID}"
dwmstat --sock="${DWMSTAT_SOCK}" &
# to check if dwmstat is running in a given graphical context/tty, check for
# existance of the file DWMSTAT_PID_FILE
echo $! > "${DWMSTAT_PID_FILE}"

# some scripts in the handlers need the DWMSTAT_SOCK variable
xbindkeys -f ~/.config/base/config/.xbindkeysrc

# set a random background
chbg rand

# no `exec` here since we want to run some code after dwm exits
dwm

# kill dwmstat instance spawned
if [ -f "${DWMSTAT_PID_FILE}" ]; then
  kill `cat "${DWMSTAT_PID_FILE}"`
  rm "${DWMSTAT_PID_FILE}"
fi
