# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

# D-bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

(sleep 3 && tint2) &

gnome-power-manager &
/usr/libexec/gnome-settings-daemon &
gnome-volume-control-applet &
nm-applet --sm-disable &
#gnome-keyring-daemon &

gnome-screensaver &
#xscreensaver &
#parcellite &

nitrogen --restore &

(sleep 60s && ~/.dropbox-dist/dropboxd) &
