# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="lc-magic"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$HOME/dotfiles/oh-my-zsh-custom"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
plugins+=(vi-mode)
#plugins+=(vim-interaction)
plugins+=(oc)
#plugins+=(kubectl)
#plugins+=(cf)
#plugins+=(go)
#plugins+=(sbt)
#plugins+=(scala)
plugins+=(pip)
plugins+=(python)
plugins+=(virtualenv)
#plugins+=(jsontool)
plugins+=(ssh-agent)
plugins+=(gpg-agent)

source $ZSH/oh-my-zsh.sh

# User configuration
command -v oc > /dev/null 2>&1 && source <(oc completion zsh)
command -v minishift > /dev/null 2>&1 && source <(minishift completion zsh)
command -v helm > /dev/null 2>&1 && source <(helm completion zsh)

# Activate vim bindings
bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
#bindkey '^R' history-incremental-search-backward

# Exports and Paths
# export MANPATH="/usr/local/man:$MANPATH"

# Locale
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'
export TERM=xterm-color

# homes and bins and paths
# to use scala with IntelliJ, set SCALA_HOME to
# export SCALA_HOME="/usr/local/opt/scala/idea"
export SCALA_HOME="/usr/local/opt/scala"
export PATH="$PATH:$SCALA_HOME/bin"
export SBT_HOME="/usr/local/opt/sbt"
export PATH="$PATH:$SBT_HOME/bin"
export JAVA_HOME="/usr/libexec/java_home --version 9"
export PATH="$PATH:$JAVA_HOME/bin"
export GOPATH="$HOME/repositories/go"
export GOROOT="/usr/local/go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"
#export RUST=

# paths
#export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
#export PATH=$PATH:"/opt/ssllabs-scan"
#export PATH=$PATH:"/opt/idea-CE/bin"

# Aliases
# Somehow tmux does not set the colors right, so we simply force it to use 256 colors
# @see: https://unix.stackexchange.com/questions/1045/getting-256-colors-to-work-in-tmux
alias tmux="tmux -2"

# Github needs the 2FA Auth
alias ghe-refresh="adp-2fa cookie \
    --global \
    --offline_token ~/.git/adp-secrets/offline.token \
    --access_token ~/.git/adp-secrets/access.token"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
#
# Performance -----------------------------------------------------------------
# recompile if needed
autoload -U compinit && compinit -u
autoload -U zrecompile && zrecompile -p ~/.{zcompdump,zshrc} > /dev/null 2>&1
# -----------------------------------------------------------------------------

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

