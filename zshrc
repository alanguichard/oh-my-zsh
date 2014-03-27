# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Oh my zsh configuration
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avp"

# Set up plugins
plugins=()
plugins+=(git)
plugins+=(git-prompt)
plugins+=(zsh-syntax-highlighting)
plugins+=(npm)
plugins+=(mvn)

# Activate Oh my zsh
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:/usr/local/bin:$PATH