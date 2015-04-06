# Miscellaneous aliases
alias lh="ll -h"
alias irc="screen -rd irc"
alias sml="rlwrap sml"
alias prolog="rlwrap gprolog"
alias twelf="rlwrap twelf-server"
alias mr="make run"
alias mysqlu="mysql -u root"
alias vimrc="vim ~/.vim/vimrc"
alias copy="xclip -selection clipboard"
alias add="git add"

# AFS Mount points
alias fsafs="sshfs avpatel@unix.andrew.cmu.edu: ~/afs"
alias ufsafs="umount ~/afs"

# Important directories
CMU="$HOME/Dropbox/cmu/"
PROGRAMMING="$HOME/Dropbox/programming/"
PEGASUS="$HOME/pegasus/"
AVP42="$HOME/Dropbox/programming/avp42/"
LYRA="$HOME/Dropbox/programming/lyra/"
ARGUS="$HOME/dev/argus"
VIM="$HOME/.vim"

alias cmu="~CMU"
alias gigastorm="cd ~/Dropbox/GigaStorm"
alias programming="~PROGRAMMING"
alias pegasus="~PEGASUS"
alias argus="~ARGUS"
alias gemini="~GEMINI"
alias pg-livereload="livereload ~PEGASUS/server"
alias elementexplorer="node /usr/local/lib/node_modules/protractor/bin/elementexplorer.js"

pgssh() {
  ssh -A ubuntu@${1}
}

pgcount() {
  local dir=$PWD
  cd $PEGASUS
  echo "CLIENT:"
  wc -l client/ts/**/*.ts client/ts/**/*.tpl.html client/less/*.less client/test/**/*.js | sort -n
  echo "SERVER:"
  wc -l server/src/**/*.java | sort -n
  echo "TOTAL:"
  wc -l client/ts/**/*.ts client/ts/**/*.tpl.html client/less/*.less client/test/**/*.js server/src/**/*.java | sort -n
  cd $dir
}

# Android aliases
alias droidconnect="sudo mtpfs -o allow_other /media/nexus4"
alias droiddisconnect="sudo umount /media/nexus4"

# Useful environment variables
export PATH=$PATH:$HOME/google_appengine
export PATH=$PATH:$HOME/intellij-idea
export PATH=$PATH:$HOME/Dropbox/bin
export PATH=$PATH:/usr/lib/smlnj/bin
export PATH=$PATH:$HOME/Library/Haskell/bin
export PATH=$PATH:$HOME/.cabal/bin
export MAVEN_OPTS="-Xmx512m -XX:MaxPermSize=512m"
export EDITOR=vim
export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages

if [[ "$(uname)" = 'Linux' ]]; then
  export TERM='xterm-256color'
  export PATH=$PATH:/opt/cuda/bin
  export CUDA_BIN_PATH=/opt/cuda/bin
fi

if [[ "$(uname)" = 'Darwin' ]]; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
  export XLISPPATH=`pwd`/runtime:`pwd`/lib
  alias nyquist="/Applications/NyquistIDE.app/Contents/Resources/Java/ny"
  alias mysql_start="mysqld_safe"
  alias vlc="/Applications/VLC.app/Contents/MacOS/VLC"
  alias gdb="sudo gdb"
fi
mysql_reset() {
  local DIR=$(pwd)
  cd ~PEGASUS/tools
  cat create_tables.sql create_testdata.sql | mysqlu pegasus
  cd $DIR
}

# For Wacom tablet
wacom() {
  xsetwacom --set 19 Button 1 "key ctrl z"
  xsetwacom --set "Wacom Bamboo 16FG 4x5 Finger touch" touch off
}
