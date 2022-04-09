#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

export TERM=xterm-256color

# helper functions
_have() { type "$1" &>/dev/null; }

# ----------------------------- history ---------------------------------------
# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth:erasedups
HISTORY_IGNORE="(ls|cd|pwd|exit|history|cd ..)"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000000
HISTFILESIZE=10000000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary, update the values
# of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will match all
# files and zero or more directories and subdirectories.
shopt -s globstar

# disable control-s accidental terminal stops
stty stop undef

# ------------------------------- vi mode -------------------------------------
set -o vi

# C-l clears screen
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

if _have nvim; then
    alias vi=nvim
    export EDITOR=nvim
    export VISUAL=nvim
elif _have vim; then
    alias vi=vim
    export EDITOR=vim
    export VISUAL=vim
else
    export EDITOR=vi
    export VISUAL=vi
fi

# --------------------------------- prompt ------------------------------------
smart_prompt=1

__ps1() {
    # colors
    local red='\[\e[1;31m\]'
    local green='\[\e[1;32m\]'
    local yellow='\[\e[1;33m\]'
    local blue='\[\e[1;34m\]'
    local magenta='\[\e[1;35m\]'
    local cyan='\[\e[1;36m\]'
    local white='\[\e[37m\]'
    local reset='\[\e[0m\]'

    local cols="$(tput cols)"

    # git branch
    local branch="$(git branch --show-current 2>/dev/null)"
    [[ -n "$branch" ]] && branch="$yellow:($branch)"

    # hostname(life saviour when ssh into a remote machine)
    [[ "$HOSTNAME" != "machine" ]] && local host="$red\u$white@$blue\h:"

    local countme="$host$cyan\w$branch$reset"

    if [[ "$smart_prompt" -ne 0 && "${#countme}" -gt "$((cols/2))" ]]; then
        PS1="╔ $countme\n╚ \$ "
    else
        PS1="$countme\$ "
    fi
}

PROMPT_COMMAND='__ps1'

# ----------------------------------- pager -----------------------------------
if [[ -x /usr/bin/lesspipe ]]; then
    export LESSOPEN="| /usr/bin/lesspipe %s";
    export LESSCLOSE="/usr/bin/lesspipe %s %s";
fi

# ----------------------------- dircolors -------------------------------------
if _have dircolors; then
    if [[ -r "$HOME/.config/dircolors" ]]; then
        eval "$(dircolors -b "$HOME/.config/dircolors")"
    else
        eval "$(dircolors -b)"
    fi
fi

# --------------------------- colors in man pages -----------------------------
export LESS_TERMCAP_mb="[1;31m"
export LESS_TERMCAP_md="[1;36m"
export LESS_TERMCAP_me="[0m"
export LESS_TERMCAP_so="[01;37;31m"
export LESS_TERMCAP_se="[0m"
export LESS_TERMCAP_us="[1;32m"
export LESS_TERMCAP_ue="[0m"

# -------------------------------- lynx ---------------------------------------
export _lynx="$(command -v lynx)"

lynx() {
    if [[ -z "$_lynx" ]]; then
        echo "Lynx does not seem to be installed"
        return 1
    fi

    [[ -r "$HOME/.config/lynx/lynx.cfg" ]] && lynxcfg="-cfg=$HOME/.config/lynx/lynx.cfg"
    [[ -r "$HOME/.config/lynx/lynx.lss" ]] && lynxlss="-lss=$HOME/.config/lynx/lynx.lss"

    "$_lynx" "$lynxcfg" "$lynxlss" "$*"
} && export -f lynx

# ----------------------------- aliases ---------------------------------------
alias ls='ls --color=auto --group-directories-first'
alias la='ls -A --color=auto --group-directories-first'
alias ll='ls -lh --color=auto --group-directories-first'
alias lal='ls -lAh --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias tx='sxiv -t * 2>/dev/null'
alias t=tmux
alias tt=transmission-remote
alias fish=asciiquarium
alias '?'=duck
alias ss='systemctl list-units --type=service'
alias vm='ssh mark@192.168.122.93'

# git & gh
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias open='gh browse >/dev/null 2>&1'

# enable programmable completion features
if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        source /etc/bash_completion
    fi
fi

owncomp=(pom vic)
for i in "${owncomp[@]}"; do complete -C "$i" "$i"; done
