#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

yum update && yum upgrade -y

yum install -y \
    vim \
    zsh \
    git \
    tmux \
    curl \
    make \
    python3 \
    golang \
    skopeo \
    buildah \
    docker

# Setup repo struct
mkdir -p ~/repositories/github.com/laidback
mkdir -p ~/repositories/go/{src,pkg,bin}

# Manual golang install
GOVERS=go1.10.3.linux-amd64.tar.gz
curl -fsSL https://dl.google.com/go/$GOVERS $GOVERS 
tar -C /usr/local -xzf $GOVERS
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=~/repositories/go

# gitlab-runner For RHEL/CentOS/Fedora
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash

# Oh-my-zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi
