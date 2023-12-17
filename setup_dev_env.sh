#!/usr/bin/env bash
# Setup Development Environment

# Add Docker's official GPG key:
if [[ "$USER" == "root" ]]; then

    # Add Docker's official GPG key:
    apt-get update
    apt-get install ca-certificates curl gnupg
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
        tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io
fi

# Install go tools and packages for the kubernetes ecosystem
# with kubectl, krew, kubetail, stern, kind and flux
go install k8s.io/kubectl@latest \
    sigs.k8s.io/kind@latest \
    github.com/fluxcd/flux2@latest \
    stern@latest \
    kubetail@latest

