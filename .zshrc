# If you come from bash you might have to change your $PATH.
FPATH="/usr/local/share/zsh/site-functions:${FPATH}"
HISTCONTROL=ignoreboth

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

# export dotfiles variables
export REPOS="${HOME}/repos"
export LAIDBACK=github.com/laidback
export DOTFILES=$REPOS/$LAIDBACK/dotfiles

# export api key variables
export GITLAB_TOKEN=$(skate get gitlab.com)
export GITHUB_TOKEN=$(skate get github.com)
export OPENAI_API_KEY=$(skate get openai.com)

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
# Golang
export GOROOT="/usr/local/go"
export GOPATH="$HOME/repos/go"

# PATH
export PATH="$GOROOT/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Java
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
export KUBECONFIG="${HOME}/.kube/kind"

# SSH
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Docker startup
# Socket via systemd: /etc/systemd/system/docker.socket
# Service via systemd: /etc/systemd/system/docker.service
# see: https://github.com/moby/moby/blob/master/contrib/init/systemd/docker.service

# Charm suite configuration
# Service via systemd: /etc/systemd/system/charm.service
# see: https://github.com/charmbracelet/charm/blob/main/systemd.md

# Zsh addons and functions
#source "$REPO_DIR/github.com/laidback/workflow-tools/workflow-tools.sh"

# Kube aliases
alias ktx="export KUBECONFIG=\$(find $HOME/.kube -maxdepth 1 -type f | gum choose)"
alias kns="kubectl config set-context --current=true \
    --namespace=\$(kubectl get namespace | cut -d ' ' -f1 | gum filter)"

# git aliases
alias glog='git log --graph --pretty="%C(yellow) Hash: %h %C(blue)Date: %ad %C(red) Message: %s " --date=human'
alias gap='git add . && git commit -m"$(gum input --prompt "commit message: ")" && git push'
alias gcc='git checkout -B $(gum input --prompt "branch name: ") && git add . && git commit -m"$(gum input --prompt "commit message: ")"'

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

# source completions for cli tools
#. <(kubectl completion zsh)
. <(helm completion zsh)
. <(charm completion zsh)
. <(flux completion zsh)
#. <(stern --completion zsh)
#. <(testkube completion zsh)
. <(glab completion -s zsh)
#. <(operator-sdk completion zsh)

# vim: ts=4 sw=4 sws=4 expandtab
. <(k8sgpt completion zsh)
