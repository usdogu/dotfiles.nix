systemctl --user import-environment DISPLAY &
xrdb -merge .Xresources &
nimblocks &
doas cpupower frequency-set -g powersave &
exec dbus-launch --sh-syntax --exit-with-session dwm
