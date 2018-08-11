#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

apt update && apt-upgrade

# This installation is for the win 10 subsystem
apt install \
    vim \
    zsh \
    git \
    tmux \
    curl \
    golang

# Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install dotfiles
echo $PWD
ls -la
