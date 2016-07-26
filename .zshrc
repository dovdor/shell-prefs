# ***************************************
# oh-my-zsh settings
export ZSH=$HOME/.oh-my-zsh

# Themes I like: 
# blinks, gentoo, af-magic
SOLARIZED_THEME=dark
ZSH_THEME="blinks-patch"

DISABLE_AUTO_UPDATE="true"

plugins=(git osx ant mercurial virutalenv brew docker aws pip sudo)

source $ZSH/oh-my-zsh.sh
# ***************************************

# ***************************************
# General setup

# set shell vars
export EDITOR=vim
export LESS="--chop-long-lines --ignore-case"

# Set Locale
export LC_ALL=en_US.UTF-8

# -R allows raw escape sequences but only for coloring
export PAGER='less -R'
export PERLDOC_PAGER='less -R'

# setup brew python directory
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH

# Publish the SSH AGENT SOCK
export SSH_AUTH_SOCK=`ps -ef | grep ssh | grep agent | awk '{print $2}' | xargs lsof -p | grep Listeners | grep unix | awk '{print $8}' | head -n1`

export HISTSIZE=50000

# Locate virtualenvwrapper binary
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export VENVWRAP=/usr/local/bin/virtualenvwrapper.sh
fi

# setup virtualenvwrapper
if [ ! -z $VENVWRAP ]; then
    # virtualenvwrapper -------------------------------------------
    # make sure env directory exists; else create it
    export WORKON_HOME=$HOME/Projects/envs
    [ -d $WORKON_HOME ] || mkdir -p $WORKON_HOME
    source $VENVWRAP

    # virtualenv --------------------------------------------------
    export VIRTUALENV_USE_DISTRIBUTE=true

    # pip ---------------------------------------------------------
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_REQUIRE_VIRTUALENV=true
    export PIP_RESPECT_VIRTUALENV=true
fi

if [ ! -z $TMUX ]; then
    if tmux list-panes -F '#{session_name}' | sort -u | wc -l | grep -q "^\s*1$"; then
	export TMUX_SESSION_NAME=$(tmux list-panes -F '#{session_name}')
	if lsvirtualenv | grep -q "^${TMUX_SESSION_NAME}$"; then
	    workon $TMUX_SESSION_NAME
	fi
    fi
fi
# ***************************************
