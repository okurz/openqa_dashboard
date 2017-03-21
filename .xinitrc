#!/bin/bash
# In case everything goes wrong, we at least fall back to a plain xterm
failsafe="xterm -ls -T Failsafe -geometry 80x24-0-0"
trap "exec $failsafe" EXIT SIGHUP SIGINT SIGPIPE SIGTERM SIGIO

# Some bash (1 and 2) settings to avoid trouble on a
# failed program call.
set +e > /dev/null 2>&1
set +u > /dev/null 2>&1
set +o posix  > /dev/null 2>&1
if type shopt > /dev/null 2>&1 ; then
    shopt -s execfail
else
    no_exit_on_failed_exec=1
fi

# Source common code shared between the
# X session and X init scripts
. /etc/X11/xinit/xinitrc.common

x11vnc -loop -forever -nopw -display :0 -auth guess &
unclutter &
$HOME/bin/o3_dashboard

xset -dpms
xset s off
xset s noblank

# finally start the window manager
unset WINDOW_MANAGER STARTUP
exec $WINDOWMANAGER ${1+"$@"}

# call failsafe
exit 0
