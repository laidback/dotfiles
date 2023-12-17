# If you come from bash you might have to change your $PATH.
FPATH="/usr/local/share/zsh/site-functions:${FPATH}"
HISTCONTROL=ignoreboth

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
ZSH_THEME="lc-magic"

# Set zsh options
unsetopt share_history

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins+=(golang)
plugins+=(kubectl)  # shortcuts e.g. kns, kgp
plugins+=(history-substring-search)
plugins+=(zsh-autosuggestions)
plugins+=(zsh-syntax-highlighting)
plugins+=(zsh-vi-mode)
plugins+=(zoxide)

# Vi mode and bindings
bindkey -v
#bindkey -M viins 'jk' vi-cmd-mode
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_VI_VISUAL_ESCAPE_BINDKEY=jk

# Autosuggest - after vim bindings!!!
bindkey '^R' history-incremental-search-backward
bindkey '^ ' autosuggest-accept # ctrl+space
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Load Oh-my-zsh
export ZSH_CUSTOM="$HOME/oh-my-zsh-custom"
source $ZSH/oh-my-zsh.sh

# Tools configuration
eval "$(zoxide init zsh)"
complete -C '/usr/local/bin/aws_completer' aws

# Exports and Paths
# Preferred global shell settings
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TERM=xterm-256color
export EDITOR='vim'

# Homes, bins and paths
# GOLANG
export GOROOT="/usr/local/go"
export GOPATH="$HOME/repos/go"
export PATH="$GOROOT/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"

# JAVA
#export JAVA_HOME="/usr/lib/jvm/temurin-17-jdk-amd64"
#export PATH="$PATH:${JAVA_HOME}/bin"

# Android
export ANDROID_HOME=/usr/lib/android-sdk
export PATH=${PATH}:${ANDROID_HOME}/emulator
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:/usr/lib/platform-tools
export PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin
export PATH="${PATH}:${HOME}/.krew/bin"

# Kubernetes PATH settings
export KUBECONFIG="${HOME}/.kube/wfm-dev"

# SSH
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Docker startup
DOCKER_DISTRO="Ubuntu-20.04"
DOCKER_DIR="/var/run/docker"
DOCKER_LOG="$DOCKER_DIR/dockerd.log"
DOCKER_SOCK="/var/run/docker.sock"

## set docker host
export DOCKER_HOST="unix://$DOCKER_SOCK"

if [ ! -S "$DOCKER_SOCK" ]; then
   echo "docker seems to be dead, starting ..."
   sudo mkdir -pm o=,ug=rwx "$DOCKER_DIR"
   sudo chgrp -R docker "$DOCKER_DIR"
   sudo chmod -R 777 "$DOCKER_DIR"
   sudo touch "$DOCKER_LOG"
   sudo -b nohup dockerd < /dev/null > $DOCKER_LOG &
fi

# Charm suite configuration
CHARM_SERVER_WORKDIR="$HOME/.charm"
CHARM_SERVER_DATA_DIR=$CHARM_SERVER_WORKDIR/data
CHARM_SERVER_LOG="$CHARM_SERVER_WORKDIR/charmd.log"
CHARM_SERVER_HOST=localhost
CHARM_SERVER_BIND_ADDRESS=0.0.0.0
CHARM_SERVER_SSH_PORT=35353
CHARM_SERVER_HTTP_PORT=35354
CHARM_SERVER_STATS_PORT=35355
CHARM_SERVER_HEALTH_PORT=35356
CHARM_SERVER_USE_TLS=false
CHARM_SERVER_TLS_KEY_FILE=
CHARM_SERVER_TLS_CERT_FILE=
CHARM_SERVER_PUBLIC_URL=
CHARM_SERVER_ENABLE_METRICS=true # http://<CHARM_SERVER_HOST>:<CHARM_SERVER_STATS_PORT>/metrics
CHARM_SERVER_USER_MAX_STORAGE=0

# change the host for the charm-client
export CHARM_HOST=localhost

# check if charm is started and restart if necessary
charm_health_url="${CHARM_SERVER_HOST}:${CHARM_SERVER_HEALTH_PORT}"

ret=$(curl --location --silent \
    --write "%{http_code}" \
    --output "/dev/null" \
    --request GET ${charm_health_url})

if [[ ${ret} -ne "200" ]]; then
    echo "charm seems to be dead, starting ..."
    mkdir -pm o=,ug=rwx "$CHARM_SERVER_DATA_DIR"
    chmod -R 755 "$CHARM_SERVER_WORKDIR"
    touch "$CHARM_SERVER_LOG"
    nohup charm serve < /dev/null > "${CHARM_SERVER_LOG}" 2>&1 &
fi

# Tools setup
export REPO_DIR="${HOME}/repos"
export GITLAB_HOST="git.buts.hilti.cloud"
export GITLAB_TOKEN=$(skate get git.buts.hilti.cloud)
export JIRA_AUTH_TYPE=bearer
export JIRA_API_TOKEN=$(skate get jira.hilti.com)
export OPENAI_API_KEY=$(skate get openai.com)

# Zsh addons and functions
#source "$REPO_DIR/git.asmgmt.hilti.com/lukas.ciszewski/workflow-tools/wft.sh"
#source "$REPO_DIR/github.com/laidback/workflow-tools/workflow-tools.sh"

# Kube aliases
alias ktx="export KUBECONFIG=\$(find -maxdepth 1 -type f $HOME/.kube | gum choose)"
alias kns="kubectl config set-context --current=true \
    --namespace=\$(kubectl get namespace | cut -d ' ' -f1 | gum filter)"

### alcoholics
# Aliases
alias pwd="pwd -P"
alias wsl="wsl.exe"
alias wish="wishlist"

# Performance -----------------------------------------------------------------
# recompile if needed
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit -u
autoload -U zrecompile && zrecompile -p ~/.{zcompdump,zshrc} > /dev/null 2>&1
# -----------------------------------------------------------------------------

eval "$(starship init zsh)"

# vim: ts=4 sw=4 sws=4 expandtab
