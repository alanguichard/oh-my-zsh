# thanks to:  http://blog.blindgaenger.net/colorize_maven_output.html
# and: http://johannes.jakeapp.com/blog/category/fun-with-linux/200901/maven-colorized
# Colorize Maven Output
alias maven="command mvn"
function color_maven() {
    local BLUE="$fg[blue]"
    local RED="$fg[red]"
    local LIGHT_RED="$fg_bold[red]"
    local LIGHT_GRAY="$fg[white]"
    local LIGHT_GREEN="$fg_bold[green]"
    local LIGHT_BLUE="$fg_bold[blue]"
    local LIGHT_CYAN="$fg_bold[cyan]"
    local YELLOW="$fg_bold[yellow]"
    local WHITE="$fg_bold[white]"
    local NO_COLOUR="$reset_color"
    command mvn $* | sed \
        -e "s/Tests run: \([^,]*\), Failures: \([^,]*\), Errors: \([^,]*\), Skipped: \([^,]*\)/${LIGHT_GREEN}Tests run: \1$NO_COLOUR, Failures: $RED\2$NO_COLOUR, Errors: $YELLOW\3$NO_COLOUR, Skipped: $LIGHT_BLUE\4$NO_COLOUR/g" \
        -e "s/\(\[\{0,1\}WARN\(ING\)\{0,1\}\]\{0,1\}.*\)/$YELLOW\1$NO_COLOUR/g" \
        -e "s/\(\[ERROR\].*\)/$RED\1$NO_COLOUR/g" \
        -e "s/\(\(BUILD \)\{0,1\}FAILURE.*\)/$RED\1$NO_COLOUR/g" \
        -e "s/\(\(BUILD \)\{0,1\}SUCCESS.*\)/$LIGHT_GREEN\1$NO_COLOUR/g" \
        -e "s/\(\[INFO\].*\)/$NO_COLOUR\1$NO_COLOUR/g"
    return $PIPESTATUS
}

alias mvn=color_maven
