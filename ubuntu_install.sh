#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

apt update && apt-upgrade

# This installation is for the win 10 subsystem
# Should do no harm on real linux
apt install \
    vim \
    zsh \
    git \
    tmux \
    curl \
    make \
    python3 \
    golang

# Setup repo struct
mkdir -p ~/repositories/github.com/laidback
mkdir -p ~/repositories/go/{src,pkg,bin}

# Manual golang install
tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=~/repositories/go

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install dotfiles
echo $PWD
ls -la
