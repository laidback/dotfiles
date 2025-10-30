#!/usr/bin/env bash
#
# Script: 02-setup_dev_env.sh
# Description: Development environment setup (DevOps tools)
# Purpose: Install Docker, Kubernetes tools, cloud CLIs, and build tools
# Platform: WSL2, Ubuntu Linux, Debian-based systems
# Requirements: Root access for some installations, user context for others
#
# Usage:
#   ./02-setup_dev_env.sh
#
# What this script does:
#   - Installs Docker CE with containerd
#   - Configures Docker group permissions
#   - Installs kubectl (Kubernetes CLI)
#   - Installs Helm package manager
#   - Installs krew (kubectl plugin manager)
#   - Installs Go-based tools (kind, stern, glab)
#   - Installs Flux CD for GitOps
#   - Installs AWS CLI v2
#   - Installs kustomize for Kubernetes manifests
#   - Installs semantic-release tools via npm
#   - Installs aws-azure-login for Azure SSO
#
# Prerequisites:
#   - Run 01-setup_dev_vm.sh first
#   - Golang and Node.js must be installed
#
# --- Docker Installation ---
if [[ "$USER" == "root" ]]; then

    # Add Docker's official GPG key:
    apt-get update
    apt-get install ca-certificates curl gnupg -y
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
        | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io -y
    sudo groupadd docker
fi
sudo usermod -aG docker $USER

# Install kubectl
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
if [[ "$USER" == "root" ]]; then
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
    apt-get update
    apt-get install kubectl -y
fi

# Install helm via package manager
if [[ "$USER" == "root" ]]; then
    curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
    apt-get install apt-transport-https --yes
    echo "deb [arch=$(dpkg --print-architecture)] https://baltocdn.com/helm/stable/debian/ all main" \
        | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
    apt-get update
    apt-get install helm -y
fi

# Install krew
# https://krew.sigs.k8s.io/docs/user-guide/setup/install/#zsh
if [[ "$USER" == "root" ]]; then
    cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
fi

# Install go tools and packages for the kubernetes ecosystem
# with kubectl, krew, kubetail, stern, kind and flux
go install sigs.k8s.io/kind@latest
go install github.com/stern/stern@latest
go install gitlab.com/gitlab-org/cli/cmd/glab@main

if [[ "$USER" == "root" ]]; then
    curl -s https://fluxcd.io/install.sh | sudo bash
fi

# Install aws cli and autocompleter for zsh
# https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html#cliv2-linux-install
if [[ "$USER" == "root" ]]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
    rm -rf ./aws
fi

# Install kustomize
# https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/
if [[ "$USER" == "root" ]]; then
    curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
    mv kustomize /usr/local/bin
fi

# Install npm semantic-release
# https://github.com/semantic-release/semantic-release
if [[ "$USER" == "root" ]]; then
    npm install --global --yes \
        @semantic-release/changelog \
        @semantic-release/gitlab \
        @semantic-release/exec \
        @semantic-release/commit-analyzer \
        @semantic-release/git \
        conventional-changelog-conventionalcommits \
        semantic-release
fi

# Install aws-azure-login
if [[ "$USER" == "root" ]]; then
    npm install -g aws-azure-login
fi

