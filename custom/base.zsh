# Shell options
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt SHORT_LOOPS

unsetopt SHARE_HISTORY

# Load more commands
autoload -U zmv
autoload -U zargs

# Fix flow control
stty -ixon

## Completions
autoload -U compinit
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Key bindings
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line

# ls aliases
alias sl="ls"
alias la="ls -A"
alias ll="ls -l"
alias lh="ls -lhS"
alias l1="ls -1"
alias l="ls"

# Configuration aliases
alias shload="source ~/.zshrc"

# Git aliases
alias tigs="tig status"
alias amend="git commit --amend"
alias commit="git commit"
alias pull="git pull"
alias gbi="git bisect"
groot() {
  local groot_dir="$(git rev-parse --show-toplevel)"
  [[ -n "${groot_dir}" ]] && cd "${groot_dir}"
}

# Make aliases
alias mk="make"
alias mkc="make clean"
alias mkck="make check"
alias mkb="make -B"

# Miscellaneous aliases
alias more="less"
alias dirstat="du -d 1 -h | sort -hr | head -n 11"
alias ip="ifconfig | grep 'inet '"
alias copy="xclip -selection clipboard"
alias v="vim"
alias m="man"

if [[ "$(uname)" = 'Linux' ]]; then
  alias open="xdg-open"
elif [[ "$(uname)" = 'Darwin' ]]; then
  alias top="top -o cpu"
  alias sort="gsort"
fi

# Encryption functions
ssl_encrypt() {
  openssl aes-256-cbc -a -salt -in $1 -out $2
}
ssl_decrypt() {
  openssl aes-256-cbc -a -d -in $1 -out $2
}

# Unix time
unix_time() {
  echo $1 | gawk '{print strftime("%c", $0)}'
}

# Randomness functions
flipcoin() {
  [[ $((RANDOM % 2)) == 0 ]] && echo TAILS || echo HEADS
}
rolldie() {
  if [[ -n "$1" ]]; then
    SIDES="$1"
  else
    SIDES=6
  fi
  echo $((RANDOM % $SIDES))
}

# Fun bit of information
alias profileme="history | awk '{print \$2}' | awk 'BEGIN {FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 30 | sort -rn"

# Useful environment variables
export EDITOR=vim
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages

# Change terminal title
title() {
  echo -n -e "\033]0;$1\007"
}
title "zsh"

# Set up simple python web server
# pyserver port sets up the server on port, with default port 8000.
pyserver() {
  python -m SimpleHTTPServer $1
}

# Given an input n, gives a random string of length n.
# If no input supplied, generates a 64 character string.
randgen() {
  if [[ $# -eq 0 ]]; then
    openssl rand -hex 32
  else
    openssl rand -hex $1 | cut -c1-$1
  fi
}

# Tomcat logs
pg_staging_log() {
  ssh pg-dev "tail -n 500 -f /var/log/tomcat7/catalina.out"
}

# Speedtest alias
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"

# What is my IP
public_ip() {
  wget -qO- http://ipecho.net/plain
  echo
}

# Manual Package Update and Cleaning
pkupdate() {
  Time="$(date +%s)"
  if [[ "$(uname -s )" = "Linux" ]]; then
    sudo echo "Arguments: $@"
    echo -e "Starting Package Update\n"
    echo -e "\nUpdating Repositories\n"
    sudo apt-get $@ update
    echo -e "\nUpdating Packages\n"
    sudo apt-get $@ upgrade
    echo -e "\nUpdating Distribution Packages\n"
    sudo apt-get $@ dist-upgrade
    echo -e "\nRemoving Unnecessary Packages\n"
    sudo apt-get $@ autoremove --purge
    echo -e "\nAutocleaning Package Download Files\n"
    sudo apt-get $@ autoclean
    echo -e "\nCleaning Package Download Files\n"
    sudo apt-get $@ clean
  elif [[ "$(uname -s)" = "Darwin" ]]; then
    echo -e "Updating Homebrew recipes"
    brew update
    echo -e "\nUpgrading Homebrew packages"
    brew upgrade --all
    echo -e "\nUpdating Homebrew casks"
    brew cask update
    echo -e "\nCleaning up"
    brew cleanup
    brew cask cleanup
  fi

  Time="$(($(date +%s) - Time))"
  echo -e "\nPackage Update Complete. Time Elapsed: ${Time}s"
}

# Pull every git directory in the pwd.
pull_with_report() {
  local dir
  local out
  dir="$1"
  if [[ -d "$dir/.git" ]]; then
    echo $(echo $dir | sed 's/.|\///g') >&2
  fi
  out="$(git --git-dir=$dir/.git --work-tree=$PWD/$dir pull 2>/dev/null)"
  if [[ -n $(echo $out | grep "Already up-to-date") ]]; then
    echo "--- $dir: no changes." >&2
  elif [[ -n $out ]]; then
    echo "+++ $dir: pulled changes." >&2
  fi
}

pulls() {
  $(
  local dirs
  for dir in */; do
    pull_with_report "$dir" > /dev/null &
  done
  wait
  )
}

# Make .zsh_history store more and not store duplicates
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTFILESIZE=100000

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && export LESSOPEN="|/usr/bin/lesspipe.sh %s"

# Alias definitions.
alias killz='killall -9 '
alias hidden='ls -a | grep "^\..*"'
alias rm='rm -i'
alias shell='ps -p $$ -o comm='
alias sml='rlwrap sml'
alias math='rlwrap MathKernel'
alias coin='rlwrap coin'
alias a='alias'

# C Aliases
alias cc='gcc -Wall -W -ansi -pedantic -O2 '
alias valgrind-leak='valgrind --leak-check=full --show-reachable=yes'

# Enable color support of ls and also add handy aliases
if [[ "$(uname)" = 'Darwin' ]]; then
  alias ls='gls --color=auto'
else
  alias ls='ls --color=auto'
fi
alias grep='grep --color=auto'

# Useful Functions
qdict(){ grep $1 /usr/share/dict/words; }

# Turn off the ability for other people to message your terminal using wall or write
mesg n

