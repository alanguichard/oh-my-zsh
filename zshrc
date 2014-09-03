# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Oh my zsh configuration
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avp"
DEFAULT_USER="avp"

DISABLE_AUTO_UPDATE="true"

# Set up plugins
plugins=()
plugins+=(git)
plugins+=(git-prompt)
plugins+=(zsh-syntax-highlighting)
plugins+=(npm)
plugins+=(mvn)
plugins+=(mvn-color)
plugins+=(gradle)
plugins+=(sublime)
plugins+=(colored-man)
plugins+=(brew)
plugins+=(brew-cask)
plugins+=(debian)

# Activate Oh my zsh
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:/usr/local/bin:$PATH
