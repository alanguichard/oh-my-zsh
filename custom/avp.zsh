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

# Key bindings
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line

# Disable messaging
mesg n

# Completions
autoload -U compinit
compinit -C
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe.sh ] && export LESSOPEN="|/usr/bin/lesspipe.sh %s"

# Miscellaneous aliases
alias a='alias'
alias coin="rlwrap coin"
alias copy="xclip -selection clipboard"
alias copy="xclip -selection clipboard"
alias dirstat="du -d 1 -h | sort -hr | head -n 11"
alias grep='grep --color=auto'
alias hidden='ls -a | grep "^\..*"'
alias ip="ifconfig | grep 'inet '"
alias killz='killall -9 '
alias m="man"
alias math='rlwrap MathKernel'
alias more="less"
alias mr="make run"
alias mycliu="mycli -u root"
alias mysqlu="mysql -u root"
alias prolog="rlwrap gprolog"
alias rm='rm -i'
alias shell='ps -p $$ -o comm='
alias shload="source ~/.zshrc"
alias sml="rlwrap sml"
alias speedtest="speedtest-cli"
alias twelf="rlwrap twelf-server"
alias v="vim"
alias valgrind-leak='valgrind --leak-check=full --show-reachable=yes'
alias vimrc="vim ~/.vim/vimrc"

if [[ "$(uname)" = 'Linux' ]]; then
  alias open="xdg-open"
elif [[ "$(uname)" = 'Darwin' ]]; then
  alias top="top -o cpu"
  alias sort="gsort"
fi

# Unix time
unix_time() {
  echo $1 | gawk '{print strftime("%c", $0)}'
}

# What is my IP
public_ip() {
  wget -qO- http://ipecho.net/plain
  echo
}

# Dictionary
qdict() {
  grep "$1" /usr/share/dict/words
}

# Make .zsh_history store more and not store duplicates
export HISTCONTROL=ignoreboth
export HISTSIZE=100000
export HISTFILESIZE=100000

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

# Manual Package Update and Cleaning
pkupdate() {
  Time="$(date +%s)"
  if [[ "$(uname -s)" = "Linux" ]]; then
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

# AFS Mount points
alias fsafs="sshfs avpatel@unix.andrew.cmu.edu: ~/afs"
alias ufsafs="umount ~/afs"

# Important directories
CMU="$HOME/Dropbox/cmu/"
PROGRAMMING="$HOME/Dropbox/programming/"
DEV="$HOME/dev"
PEGASUS="$HOME/pegasus/"
ARGUS="$HOME/dev/argus"
VIM="$HOME/.vim"

alias cmu="~CMU"
alias gigastorm="cd ~/Dropbox/GigaStorm"
alias programming="~PROGRAMMING"
alias pegasus="~PEGASUS"
alias argus="~ARGUS"
alias pg-livereload="livereload ~PEGASUS/server"
alias elementexplorer="node /usr/local/lib/node_modules/protractor/bin/elementexplorer.js"

pgssh() {
  ssh -A ubuntu@${1}
}

pgcount() {
  local dir="$PWD"
  cd $PEGASUS
  echo "CLIENT:"
  wc -l \
    client/ts/**/*.ts \
    client/ts/**/*.tpl.html \
    client/less/*.less \
    client/test/**/*.js \
    | sort -n
  echo "SERVER:"
  wc -l server/src/**/*.java | sort -n
  echo "TOTAL:"
  wc -l client/ts/**/*.ts client/ts/**/*.tpl.html client/less/*.less client/test/**/*.js server/src/**/*.java | sort -n
  cd $dir
}

# Useful environment variables
export PATH="$PATH:$HOME/google_appengine"
export PATH="$PATH:$HOME/intellij-idea"
export PATH="$PATH:$HOME/Dropbox/bin"
export PATH="$PATH:/usr/lib/smlnj/bin"
export PATH="$PATH:$HOME/Library/Haskell/bin"
export PATH="$PATH:$HOME/.cabal/bin"
export MAVEN_OPTS="-Xmx512m"
export EDITOR="vim"
# export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages

if [[ "$(uname)" = 'Linux' ]]; then
  export TERM='xterm-256color'
  export PATH="$PATH:/opt/cuda/bin"
  export CUDA_BIN_PATH="/opt/cuda/bin"
  export OpenCV_DIR="/usr/share/opencv"
fi

if [[ "$(uname)" = 'Darwin' ]]; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
  alias mysql_start="mysqld_safe"
  alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
  alias gdb="sudo gdb"
fi

mysql_reset() {
  local DIR="$PWD"
  cd ~PEGASUS/tools
  cat create_tables.sql create_testdata.sql | mysqlu pegasus
  cd $DIR
}

pg_staging_log() {
  ssh pg-dev "tail -n 500 -f /var/log/tomcat7/catalina.out"
}

# For Wacom tablet
wacom() {
  xsetwacom --set 19 Button 1 "key ctrl z"
  xsetwacom --set "Wacom Bamboo 16FG 4x5 Finger touch" touch off
}
