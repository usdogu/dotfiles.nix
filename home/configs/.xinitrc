systemctl --user import-environment DISPLAY &
xrdb -merge .Xresources &
nimblocks &
exec dbus-launch --sh-syntax --exit-with-session dwm
