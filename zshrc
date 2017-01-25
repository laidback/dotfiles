# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="af-magic"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-syntax-highlightning)
plugins+=(cargo)
plugins+=(ubuntu)
plugins+=(git)
plugins+=(go)
plugins+=(nmap)
plugins+=(python)
plugins+=(rsync)
plugins+=(rust)
plugins+=(sbt)
plugins+=(scala)
plugins+=(ssh-agent)
plugins+=(systemd)
plugins+=(tmux)
plugins+=(vagrant)
plugins+=(pip)
plugins+=(k)
plugins+=(zsh-completions)

source $ZSH/oh-my-zsh.sh

# User configuration
# Add vim bindings
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

# --- Exports and Paths ---
# term
export TERM=xterm-256color

# locale
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# editor 
export EDITOR='vim'

# SSH settings
export SSH_KEY_PATH="~/.ssh/rsa_id"

# homes and bin
export SCALA_HOME="/usr/local/share/scala"
#export ACTIVATOR_HOME=
#export SBT_HOME=
#export JAVA_HOME=
#export RUST=
export GOPATH=/usr/local/go
export GOROOT=/usr/lib/go

# paths
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=$PATH:"/opt/activator"
export PATH=$PATH:"/opt/ssllabs-scan"
export PATH=$PATH:"/opt/idea-CE/bin"
export PATH=$PATH:"$SCALA_HOME/bin"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

autoload -U compinit && compinit

# Aliases
alias ~="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Performance -----------------------------------------------------------------
# recompile if needed
autoload -U zrecompile && zrecompile -p ~/.{zcompdump,zshrc} > /dev/null 2>&1
# -----------------------------------------------------------------------------

