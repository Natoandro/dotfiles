#!/bin/sh

# killall polybar
# polybar -r &
systemctl --user start dunst
systemctl --user start docker-desktop
compton
setxkbmap us,fr

xautolock -time 10 -locker slock

# sleep 1
# polybar-msg cmd hide

. .screenlayout/default.sh

