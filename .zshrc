# export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="/home/lampis/.oh-my-zsh"
export PATH="/home/lampis/.local/bin:$PATH"
export EDITOR="/usr/bin/vim"
ZSH_THEME="lambda"
plugins=(zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
alias zshconfig="vim ~/.zshrc"
alias ihatemylife="doas emerge --sync && doas emerge -avuDt --changed-use --with-bdeps=y @world && doas emerge nvidia-drivers && doas grub-mkconfig -o /boot/grub/grub.cfg"
alias sudo="echo STOP USING BLOAT AND USE DOAS NOW"
alias reboot="doas reboot"
