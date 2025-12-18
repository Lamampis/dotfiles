## Start
userresources=$HOME/.Xresources

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

## Start some programs
/usr/libexec/polkit-gnome-authentication-agent-1 &
#~/Applications/appimaged-817-x86_64.AppImage daemon &
udiskie &
slstatus &
nitrogen --restore
mpd

## Screensaver Settings
#xset s off
#xset s 0 0
xset s 1800
xset +dpms
xautolock -time 31 -locker slock &

## Set some settings
#hsetroot -solid '#000000'
xsetroot -cursor_name Left_ptr # Mouse Cursor
setxkbmap -model pc104 -layout us,gr -variant ,, -option grp:alt_shift_toggle # US/GR keymap
xinput set-prop 'TPPS/2 IBM TrackPoint' 'libinput Accel Speed' 1 # Sensitivity

## Start X with any WM:
## startx ~/.xinitrc <name-of-wm>
while type "$@" >/dev/null ; do "$@" && continue || break ;done
