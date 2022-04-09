#!/bin/bash

if [[ -n "$BASH_VERSION" ]]; then
    # include .bashrc if it exists
    [[ -f "$HOME/.bashrc" ]] && . "$HOME/.bashrc"

    # --------------------------------- PATH ----------------------------------
    pathappend() {
        declare arg
        for arg in "$@"; do
            test -d "$arg" || continue
            PATH=${PATH//":$arg:"/:}
            PATH=${PATH/#"$arg:"/}
            PATH=${PATH/%":$arg"/}
            export PATH="${PATH:+"$PATH:"}$arg"
        done
    }

    pathprepend() {
        for arg in "$@"; do
            test -d "$arg" || continue
            PATH=${PATH//:"$arg:"/:}
            PATH=${PATH/#"$arg:"/}
            PATH=${PATH/%":$arg"/}
            export PATH="$arg${PATH:+":${PATH}"}"
        done
    }

    # remember last arg will be first in path
    pathprepend \
        /usr/bin \
        /usr/local/bin \
        /usr/local/sbin

    pathappend \
        "$HOME/.local/scripts" \
        "$HOME/.local/bin" \
        "$HOME/.local/share/go/bin" \
        "$HOME/.local/share/npm-global/bin"

    # --------------------------------- CDPATH --------------------------------
    export CDPATH=".:$HOME:$HOME/Repos:$HOME/Repos/private"
fi

# ----------------------------- exports ---------------------------------------
export READER=zathura
export BROWSER=brave
export TERMINAL='alacritty'
export COLORTERM='truecolor'

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="$HOME/.local/share/runtime"

export LC_ALL='en_US.UTF-8'
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export FZF_DEFAULT_OPTS="--layout=reverse --height 50%"
export _JAVA_AWT_WM_NONREPARENTING=1 # Fix for Java applications in dwm
export QT_QPA_PLATFORMTHEME="qt5ct"
export MPD_PORT="7000"
export MOZ_USE_XINPUT2="1"  # Mozilla smooth scrolling/touchpads.
export XDEB_PKGROOT="$HOME"/.local/builds/xdeb

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# clean up
export LESSHISTFILE="-"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch"
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export GOPATH="$XDG_DATA_HOME"/go
export GOBIN="$GOPATH"/bin
export NUGET_PACKAGES="$XDG_CACHE_HOME/"NuGetPackages
export prefix="$XDG_DATA_HOME"/npm
export cache="$XDG_CACHE_HOME"/npm
export tmp="$XDG_RUNTIME_DIR"/npm
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/password-store
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export ANDROID_HOME=$HOME/Android/SDK
export ANDROID_SDK_ROOT=$HOME/Android/SDK
export NPM_CONFIG_PREFIX=$HOME/.local/share/npm-global
# export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
