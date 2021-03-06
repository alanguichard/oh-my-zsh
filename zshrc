# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Oh my zsh configuration
ZSH_THEME="avp"
ZSH="$HOME/.oh-my-zsh"
DEFAULT_USER="avp"

DISABLE_AUTO_UPDATE="true"

# Set up plugins
plugins=(
  android
  bower
  brew
  brew-cask
  cabal
  colored-man
  colorize
  cp
  crypto
  git
  git-prompt
  gradle
  ls
  make
  mvn
  mvn-color
  npm
  osx
  python
  random
  screen
  sublime
  sudo
  tmux
  zsh-syntax-highlighting
  zsh_reload
)

# Activate Oh my zsh
source "$ZSH/oh-my-zsh.sh"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
