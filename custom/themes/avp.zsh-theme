PS1=\
'%B%F{green}%n@%m%F{reset}%b'\
'%(2L,%F{yellow}[%L]%F{reset},)'\
'%(1j,%F{cyan}[%j]%F{reset},)'\
' '\
'%B%F{blue}%~%F{reset}%b'\
'%F{red}$(git_prompt_string)%F{reset}'\
'%(!,#,) '

RPS1=\
'%(1?,%F{red}[%?]%F{reset} ,)'\
'%F{cyan}[%*]%F{reset}'

GIT_PROMPT_SYMBOL=""
GIT_PROMPT_PREFIX=" "
GIT_PROMPT_SEPARATOR=" "
GIT_PROMPT_SUFFIX=""
GIT_PROMPT_EQUAL="%{$fg[blue]%}‖%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[green]%}↑%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}↓%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[white]%}⚔%{$reset_color%}"
GIT_PROMPT_REBASING="%{$fg_bold[white]%}♞%{$reset_color%}"
GIT_PROMPT_CHERRYPICKING="%{$fg_bold[white]%}©%{$reset_color%}"
GIT_PROMPT_BISECTING="%{$fg_bold[white]%}✂%{$reset_color%}"
GIT_PROMPT_STASHED="%{$fg_bold[white]%}∫%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
