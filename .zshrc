# export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="/home/lampis/.oh-my-zsh"
export PATH="/home/lampis/.local/bin:$PATH"
ZSH_THEME="lambda"
ENABLE_CORRECTION="true"
plugins=(zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias zshconfig="vim ~/.zshrc"
alias ihatemylife="doas emerge -avuDt --changed-use --with-bdeps=y @world"
alias sudo="echo STOP USING BLOAT AND USE DOAS NOW"
alias reboot="doas reboot"
