#!/bin/sh

# profile.sh
# jessy@jessywilliams.com

# ------------------------------------------------------------------------------

# determine platform
case $(uname) in
*BSD* | Dragon*) export PLATFORM='bsd' ;;
Darwin*) export PLATFORM='macos' ;;
Linux*) export PLATFORM='linux' ;;
CYGWIN* | MINGW*) export PLATFORM='windows' ;;
SunOS*) export PLATFORM='solaris' ;;
*) export PLATFORM='unknown' ;;
esac

# determine linux distribution
if [ $PLATFORM = 'linux' ]; then
    if cat /etc/*release | grep -q "^NAME=.*Arch"; then
        export DISTRO='arch'
    elif cat /etc/*release | grep -q "^NAME=.*CentOS"; then
        export DISTRO='centos'
    elif cat /etc/*release | grep -q "^NAME=.*Red"; then
        export DISTRO='redhat'
    elif cat /etc/*release | grep -q "^NAME=.*Fedora"; then
        export DISTRO='fedora'
    elif cat /etc/*release | grep -q "^NAME=.*Ubuntu"; then
        export DISTRO='ubuntu'
    elif cat /etc/*release | grep -q "^NAME=.*Debian"; then
        export DISTRO='debian'
    elif cat /etc/*release | grep -q "^NAME=.*Mint"; then
        export DISTRO='mint'
    elif cat /etc/*release | grep -q "^NAME=.*Knoppix"; then
        export DISTRO='knoppix'
    else
        export DISTRO='other'
    fi
else
    export DISTRO='other'
fi

# add user bin directory to PATH
[ -d "${HOME}/bin" ] && PATH="$HOME/bin:$PATH"

# add user library paths
[ -d "$HOME/lib" ] && LD_LIBRARY_PATH="$HOME/lib:$LD_LIBRARY_PATH"
[ -d "$HOME/share" ] && XDG_DATA_DIRS="$HOME/share:$XDG_DATA_DIRS"
[ -d "$HOME/include" ] && C_INCLUDE_PATH="$HOME/include:$C_INCLUDE_PATH"

# editor
if exists 'vim'; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

# web
export WWW_HOME=google.com

# history
export HISTFILE="$HOME/.history"
export HISTFILESIZE=50000
export HISTSIZE=$HISTFILESIZE
export SAVEHIST=$HISTFILESIZE
export HISTCONTROL=ignoreboth:erasedups
touch "$HISTFILE"

# basic prompt
case "$-" in
*i*) PS1="$USER@$(uname -n) $ " ;;
esac

# directories
export DL="$HOME/Downloads"
if [ -e "$HOME/Sync" ]; then
    export SYNC="$HOME/Sync"
    export HW="$SYNC/School"
    export DEV="$SYNC/Development"
    export DOT="$DEV/dotfiles"
fi

# coreutils
if exists 'gls'; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    export COREUTILS=1
fi

# ls
export CLICOLOR=1
export LSCOLORS='HxfxgxgxexexexexexExEx'
export LS_COLORS='di=1:ln=36:so=36:pi=36:ex=35:bd=37;44:cd=34:su=34:sg=34:tw=1;1:ow=1'

# fzf
if exists 'fd'; then
    export FZF_DEFAULT_COMMAND='fd --type f --exclude node_modules'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi