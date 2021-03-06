# ***************************************
# oh-my-zsh settings
export ZSH=$HOME/.oh-my-zsh

# Themes I like: 
# blinks, gentoo, af-magic
SOLARIZED_THEME=dark
ZSH_THEME="blinks-patch"
ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"

DISABLE_AUTO_UPDATE="true"

plugins=(git osx ant virtualenv docker aws pip sudo zsh-autosuggestions vi-mode autojump fzf ripgrep)

source $ZSH/oh-my-zsh.sh
# ***************************************

# ***************************************
# General setup
# Path
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/mongodb-community@4.0/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH="/usr/local/opt/node@12/bin:$PATH"
# enforce python 3.9
export PATH="/usr/local/opt/python@3.9/libexec/bin:/usr/local/opt/python@3.9/bin:$PATH"

export GOBIN="$HOME/.go/bin"

# set shell vars
export EDITOR=vim

# Set Locale
export LC_ALL=en_US.UTF-8

export LESS="--chop-long-lines --ignore-case"
# no-init was added to support the damage done to the terminal by dog
# export LESS="$LESS --no-init"
# -R allows raw escape sequences but only for coloring
# fixes git diff/git branch showing ANSI code gibberish
export PAGER='less -R'
export PERLDOC_PAGER='less -R'

# doing it side by side on purpose as ohmyzsh sets it anyway
# disabling the LESS env var and PAGER since both bring some issues
# let's try without them
unset LESS
unset PAGER

# Disable Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1
# Publish the SSH AGENT SOCK
# disabled for now, looks like ssh-agent starts automatically
#if [ ! $(ps -ef | grep -q "[s]sh-agent -l") ]; then
#	launchctl start org.openbsd.ssh-agent
#fi

if [[ -z $SSH_AUTH_SOCK ]]; then
	export SSH_AUTH_SOCK=`ps -ef | grep ssh | grep agent | awk '{print $2}' | xargs lsof -p | grep Listeners | grep unix | awk '{print $8}' | head -n1`
fi

export HISTSIZE=50000

# fzf setup
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

# Locate virtualenvwrapper binary
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
	export VENVWRAP=/usr/local/bin/virtualenvwrapper.sh
	export VIRTUALENVWRAPPER_PYTHON=$(which python)
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
		export TMUX_SESSION_NAME=$(tmux list-panes -F '#{session_name}' | head -1)
		if lsvirtualenv | grep -q "^${TMUX_SESSION_NAME}$"; then
			workon $TMUX_SESSION_NAME
		fi
	fi
fi
