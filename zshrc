# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/lcb/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="af-magic"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmux)
plugins+=(zsh-completions)
plugins+=(vagrant)
plugins+=(pip)
plugins+=(k)
autoload -U compinit && compinit

# User configuration
# Add vim bindings
bindkey -v
bindkey -M viins 'jj' vi-cmd-mode
bindkey '^R' history-incremental-search-backward

export SCALA_HOME="/usr/local/share/scala"
export PATH=$PATH:"$SCALA_HOME/bin"

#export SCALA_HOME=
#export SBT_HOME=
#export JAVA_HOME=
#export RUST=

export GOROOT=/usr/lib/go
export GOPATH=$GOROOT/bin
#export PATH=$PATH:"$SCALA_HOME/bin"

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export PATH=$PATH:"/opt/activator"
export PATH=$PATH:"/opt/ssllabs-scan"
export PATH=$PATH:"/opt/idea-CE/bin"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# SSH settings
export SSH_KEY_PATH="~/.ssh/rsa_id"
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Aliases
