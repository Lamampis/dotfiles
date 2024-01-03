#!/bin/sh


##set status bar output grep -oP '\d+'| 

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -n "`/etc/X11/chooser.sh`" ]; then
 command="`/etc/X11/chooser.sh`"
else
 failsafe="yes"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?* ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


[D-BUS Service]
Name=org.freedesktop.Notifications
Exec=/usr/bin/dunst

##Start
/usr/libexec/polkit-gnome-authentication-agent-1 &
#hsetroot -solid '#000000'
xset s off
xset s 0 0
xset -dpms
xsetroot -cursor_name Left_ptr
setxkbmap -model pc104 -layout us,gr -variant ,, -option grp:alt_shift_toggle
feh --bg-scale crt.png
#startx ~/.xinitrc <name-of-wm>
exec "$@"
