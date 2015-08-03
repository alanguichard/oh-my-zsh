# Source original git plugin and add our own customizations
source "$ZSH/plugins/git/git.plugin.zsh"

# Git aliases
alias tigs="tig status"
alias gds="git diff --stat"
alias gbi="git bisect"

# Go to git root
groot() {
  local groot_dir="$(git rev-parse --show-toplevel)"
  [[ -n "${groot_dir}" ]] && cd "${groot_dir}"
}

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

# Pull every git directory in the pwd.
pulls() {
  $(
  local dirs
  for dir in */; do
    pull_with_report "$dir" > /dev/null &
  done
  wait
  )
}
