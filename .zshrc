# ***************************************
# oh-my-zsh settings
export ZSH=$HOME/.oh-my-zsh

# Themes I like: 
# blinks, gentoo, af-magic
SOLARIZED_THEME=dark
ZSH_THEME="blinks-patch"
ZSH_CUSTOM="$HOME/.oh-my-zsh-custom"

DISABLE_AUTO_UPDATE="true"

###########################
# zsh-vi-mode setup
function zvm_config() {
    ZVM_VI_ESCAPE_BINDKEY=jk
    ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
}

function post_zvm_init() {
    # fzf plugin clashes with zsh-vi-mode, so setting up fzf manually
    fzf_root="$(brew --prefix fzf 2>/dev/null)"
    [ -d "$fzf_root" ] || echo "fzf not installed"
    fzf_shell="$fzf_root/shell"
    [ -d "$fzf_shell" ] && source "$fzf_shell/completion.zsh" && source "$fzf_shell/key-bindings.zsh"
}
zvm_after_init_commands=(post_zvm_init)
###########################

plugins=(git macos ant virtualenv docker aws pip sudo zsh-autosuggestions autojump ripgrep kubectl kube-ps1 zsh-vi-mode bgnotify-clone)

source $ZSH/oh-my-zsh.sh
# ***************************************

# ***************************************
# General setup
# Path
# Add homebrew`
export PATH="/opt/homebrew/bin:$PATH"

# enforce python 3.11
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"

export PATH="$HOME/Projects/hawking/pe-scripts/bin:$PATH"

export GOBIN="$HOME/.go/bin"

# Local additions
export PATH="$PATH:$HOME/bin"

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
# unset LESS
# unset PAGER

# Disable Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1
# Publish the SSH AGENT SOCK
# disabled for now, looks like ssh-agent starts automatically
#if [ ! $(ps -ef | grep -q "[s]sh-agent -l") ]; then
#	launchctl start org.openbsd.ssh-agent
#fi

# turn off kubectl prompt by default
export ZPROMPT_KPS1=no

if [[ -z $SSH_AUTH_SOCK ]]; then
	export SSH_AUTH_SOCK=`ps -ef | grep ssh | grep agent | awk '{print $2}' | xargs lsof -p | grep Listeners | grep unix | awk '{print $8}' | head -n1`
fi

export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE

# fzf setup
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

###############
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
if type pyenv > /dev/null; then
  command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi

virtualenvwrapper_path="/opt/homebrew/bin/virtualenvwrapper.sh"
# Locate virtualenvwrapper binary
if [ -f $virtualenvwrapper_path ]; then
	export VENVWRAP=$virtualenvwrapper_path
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
