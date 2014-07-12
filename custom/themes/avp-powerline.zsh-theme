# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)'&&DROP USER;
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment green black "%(!.%{%F{yellow}%}.)$user@%m"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  GIT_PROMPT_SYMBOL=""
  GIT_PROMPT_PREFIX="%{$fg[black]%}"
  GIT_PROMPT_SEPARATOR=" "
  GIT_PROMPT_SUFFIX=""
  GIT_PROMPT_EQUAL="%{$fg[blue]%}‖"
  GIT_PROMPT_AHEAD="%{$fg[green]%}↑"
  GIT_PROMPT_BEHIND="%{$fg[magenta]%}↓"
  GIT_PROMPT_MERGING="%{$fg[white]%}⚔"
  GIT_PROMPT_REBASING="%{$fg[white]%}♞"
  GIT_PROMPT_CHERRYPICKING="%{$fg[white]%}©"
  GIT_PROMPT_BISECTING="%{$fg[white]%}✂"
  GIT_PROMPT_STASHED="%{$fg[white]%}∫"
  GIT_PROMPT_UNTRACKED="%{$fg[red]%}●"
  GIT_PROMPT_MODIFIED="%{$fg[yellow]%}●"
  GIT_PROMPT_STAGED="%{$fg[green]%}●"

  local git_where="$(parse_git_branch)"
  local branch="${git_where#(refs/heads/|tags/)}"
  [[ -n "$branch" ]] && prompt_segment red black "$branch"
  [[ -n "$branch" ]] && prompt_segment black default "$(parse_git_state)"
  #[[ -n "$branch" ]] && prompt_segment red black "$(git_prompt_string)"
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue white '%~'
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  echo -ne $symbols
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_context
  prompt_dir
  prompt_git
  #echo -ne "%{$reset_color%}"
  [[ -z "$(parse_git_branch)" ]] && prompt_end
  [[ -n "$(parse_git_branch)" ]] && echo -ne "%{%k%f%}"
}

build_right_prompt() {
  RETVAL=$?
  prompt_status
}

PS1='%{%f%b%k%}$(build_prompt) '
RPS1='%{%f%b%k%}$(build_right_prompt) '

