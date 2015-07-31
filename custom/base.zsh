# Shell options
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt NO_NOMATCH
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

# Configuration aliases
alias shload="source ~/.zshrc"

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

# Make .zsh_history store more and not store duplicates
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTFILESIZE=100000

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && export LESSOPEN="|/usr/bin/lesspipe.sh %s"

# Alias definitions.
alias a='alias'
alias killz='killall -9 '
alias hidden='ls -a | grep "^\..*"'
alias rm='rm -i'
alias shell='ps -p $$ -o comm='
alias math='rlwrap MathKernel'
alias grep='grep --color=auto'

# C Aliases
alias valgrind-leak='valgrind --leak-check=full --show-reachable=yes'

# Useful Functions
qdict() {
  grep "$1" /usr/share/dict/words
}

# Turn off the ability for other people to message your terminal using wall or write
mesg n
