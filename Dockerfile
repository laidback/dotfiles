# Personal Dotfiles Development Container
# Complete CLI development environment
FROM ubuntu:22.04

ARG TARGETPLATFORM
ARG TARGETARCH

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Core utilities and build tools
RUN apt-get update && apt-get install -y \
    bash \
    zsh \
    curl \
    wget \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    apt-transport-https \
    git \
    vim \
    tree \
    jq \
    unzip \
    build-essential \
    cmake \
    python3 \
    python3-dev \
    python3-pip \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Node.js 21 LTS via NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Java 21 LTS
RUN apt-get update && apt-get install -y \
    openjdk-21-jdk \
    openjdk-21-jre \
    && rm -rf /var/lib/apt/lists/*

# Go 1.21.5
RUN GO_ARCH=$(case ${TARGETARCH} in \
        amd64) echo "amd64" ;; \
        arm64) echo "arm64" ;; \
        *) echo "amd64" ;; \
    esac) \
    && curl -fsSL https://go.dev/dl/go1.21.5.linux-${GO_ARCH}.tar.gz | tar -C /usr/local -xz \
    && ln -s /usr/local/go/bin/go /usr/local/bin/go \
    && ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt

ENV GOROOT=/usr/local/go
ENV GOPATH=/root/repos/go
ENV PATH="${GOROOT}/bin:${GOPATH}/bin:${PATH}"

# Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
    && apt-get update \
    && apt-get install -y docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

# Kubernetes tools
RUN K8S_ARCH=$(case ${TARGETARCH} in \
        amd64) echo "amd64" ;; \
        arm64) echo "arm64" ;; \
        *) echo "amd64" ;; \
    esac) \
    && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${K8S_ARCH}/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/local/bin/ \
    && curl https://get.helm.sh/helm-v3.12.0-linux-${K8S_ARCH}.tar.gz | tar -xz \
    && mv linux-${K8S_ARCH}/helm /usr/local/bin/ \
    && rm -rf linux-${K8S_ARCH}

# Flux CD
RUN curl -s https://fluxcd.io/install.sh | bash

# kustomize
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash \
    && mv kustomize /usr/local/bin/

# AWS CLI
RUN AWS_ARCH=$(case ${TARGETARCH} in \
        amd64) echo "x86_64" ;; \
        arm64) echo "aarch64" ;; \
        *) echo "x86_64" ;; \
    esac) \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-${AWS_ARCH}.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws awscliv2.zip

# GitLab CLI
RUN GLAB_VERSION="1.72.0" \
    && GLAB_ARCH=$(case ${TARGETARCH} in \
        amd64) echo "amd64" ;; \
        arm64) echo "arm64" ;; \
        *) echo "amd64" ;; \
    esac) \
    && curl -fsSL https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_linux_${GLAB_ARCH}.tar.gz | tar -xz -C /tmp \
    && mv /tmp/bin/glab /usr/local/bin/glab \
    && chmod +x /usr/local/bin/glab \
    && rm -rf /tmp/bin

# Go tools
RUN go install sigs.k8s.io/kind@latest \
    && go install github.com/stern/stern@latest

# Charm tools (gum, mods, skate, glow)
RUN GUM_VERSION="0.17.0" \
    && GUM_ARCH=$(case ${TARGETARCH} in \
        amd64) echo "x86_64" ;; \
        arm64) echo "arm64" ;; \
        *) echo "x86_64" ;; \
    esac) \
    && curl -fsSL https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_Linux_${GUM_ARCH}.tar.gz | tar -xz -C /tmp \
    && mv /tmp/gum /usr/local/bin/gum \
    && chmod +x /usr/local/bin/gum \
    && rm -rf /tmp/*

# Oh-My-Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Zsh plugins
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode

# Starship prompt
RUN curl -sS https://starship.rs/install.sh | sh -s -- --yes

# Zoxide
RUN curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# Vim plugin managers
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim \
    && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Copy dotfiles
COPY .zshrc /root/.zshrc
COPY .vimrc /root/.vimrc
COPY oh-my-zsh-custom /root/oh-my-zsh-custom
COPY .config /root/.config

# Set zsh as default shell
ENV SHELL=/bin/zsh
WORKDIR /root

CMD ["/bin/zsh"]
