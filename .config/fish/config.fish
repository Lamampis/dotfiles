﻿if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

export EDITOR="/usr/bin/vim"
alias ihatemylife="doas emerge --getbinpkg -avuDt --changed-use --with-bdeps=y @world" 
alias sudo="doas"
alias reboot="doas reboot"
alias shutdown="doas openrc-shutdown --poweroff now"
#alias wf-recorder=(wf-recorder --audio -f /home/lampis/Videos/Recording-"$(date +"%T-%d-%m-%y")".mkv -g "$(slurp)")

# Created by `pipx` on 2024-06-20 17:59:21
set PATH $PATH /home/lampis/.local/bin
