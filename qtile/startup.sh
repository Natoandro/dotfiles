#!/bin/sh

# killall polybar
# polybar -r &
systemctl --user start dunst
compton
setxkbmap us,fr

xautolock -time 10 -locker slock

# sleep 1
# polybar-msg cmd hide

. .screenlayout/default.sh

