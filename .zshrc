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
    # ZVM_VI_ESCAPE_BINDKEY=jk
    ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
}

function post_zvm_init() {
    # fzf plugin clashes with zsh-vi-mode, so setting up fzf manually
    fzf_root="$(brew --prefix fzf 2>/dev/null)"
    [ -d "$fzf_root" ] || echo "fzf not installed"
    fzf_shell="$fzf_root/shell"
    [ -d "$fzf_shell" ] && source <(fzf --zsh)
}
zvm_after_init_commands=(post_zvm_init)
###########################
# bgnotify-clone setup
# set timeout to 7s
bgnotify_threshold=7
###########################

plugins=(git macos virtualenv docker aws pip sudo zsh-autosuggestions kubectl kube-ps1 zsh-vi-mode bgnotify-clone brew zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
# ***************************************

# ***************************************
# General setup

# Path
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"
export PATH="$HOME/Projects/hawking/pe-scripts/bin:$PATH"
export GOBIN="$HOME/.go/bin"
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"

# set shell vars
export EDITOR=vim

# Set Locale
export LC_ALL=en_US.UTF-8

export LESS="--chop-long-lines --ignore-case"
export PAGER='less -R'
export PERLDOC_PAGER='less -R'

# Disable Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

# turn off kubectl prompt by default
export ZPROMPT_KPS1=no

if [[ -z $SSH_AUTH_SOCK ]]; then
    export SSH_AUTH_SOCK=$(launchctl getenv SSH_AUTH_SOCK)
fi

export HISTSIZE=10000000
export SAVEHIST=$HISTSIZE

# fzf setup
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border --preview="bat --color=always --theme gruvbox-dark"'
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

# zoxide (autojump replacement)
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"
# Source work-specific overrides if present
[[ -f ~/Projects/shell-prefs-sfdc/sfdc.zsh ]] && source ~/Projects/shell-prefs-sfdc/sfdc.zsh
