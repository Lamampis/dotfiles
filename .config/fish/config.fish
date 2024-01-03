if status is-interactive
    # Commands to run in interactive sessions can go here
end

export EDITOR="/usr/bin/vim"
alias ihatemylife="doas emerge -avuDt --changed-use --with-bdeps=y @world && doas emerge nvidia-drivers && doas grub-mkconfig -o /boot/grub/grub.cfg"
alias sudo="echo STOP USING BLOAT AND USE DOAS NOW && doas"
alias reboot="doas reboot"
alias feh="feh -B black"
