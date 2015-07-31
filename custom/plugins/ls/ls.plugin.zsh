# ls aliases
alias sl="ls"
alias la="ls -A"
alias ll="ls -l"
alias lh="ls -lhS"
alias l1="ls -1"
alias l="ls"

# Enable color support of ls and also add handy aliases
if [[ "$(uname)" = 'Darwin' ]]; then
  alias ls='gls --color=auto'
else
  alias ls='ls --color=auto'
fi
