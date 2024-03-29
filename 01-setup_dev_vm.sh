#!/usr/bin/env bash
# Setup WSL

# on windows show all distros
# wsl.exe --list
# unregister default Ubuntu
# wsl.exe --unregister Ubuntu

# install Ubuntu again
# wsl.exe --list

# --- now on Linux
if [[ "$USER" == "root" ]]; then
    locale-gen en_US.UTF-8
    apt update -y && apt upgrade -y
    apt install software-properties-common -y
    add-apt-repository ppa:git-core/ppa -y
    add-apt-repository ppa:jonathonf/vim -y
fi

# add nodesource
if [[ "$USER" == "root" ]]; then
    curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh
    chmod 500 nsolid_setup_deb.sh
    sudo ./nsolid_setup_deb.sh 21
    rm --force nsolid_setup_deb.sh
fi

# install base packages
if [[ "$USER" == "root" ]]; then
    apt update && apt install zsh git vim \
        nodejs vim-nox build-essential cmake \
        python3-dev mono-complete openjdk-17-jdk openjdk-17-jre \
        jq xdg-utils -y
fi

# setup repos and dotfile paths
export REPOS=$HOME/repos
export LAIDBACK=github.com/laidback
export DOTFILES=$REPOS/$LAIDBACK/dotfiles
test -d $DOTFILES && rm -rf $DOTFILES && mkdir -p $DOTFILES
git clone https://$LAIDBACK/dotfiles $DOTFILES

# install golang
if [[ "$USER" == "root" ]]; then
    rm -rf /usr/local/go
    GOPATH=$REPOS/go
    curl -sLO https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
    tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
    rm go1.21.5.linux-amd64.tar.gz
    GOROOT=/usr/local/go
fi
export PATH=$PATH:/usr/local/go/bin

# zsh settings
echo "change shell to zsh"
chsh -s /bin/zsh $USER

# install oh-my-zsh
test -d $HOME/.oh-my-zsh && rm -rf $HOME/.oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | zsh

# install dotfiles
test -f $HOME/.zshrc && rm $HOME/.zshrc
ln -s $DOTFILES/.zshrc $HOME/.zshrc

export ZSH_CUSTOM=$HOME/oh-my-zsh-custom
test -d $ZSH_CUSTOM && rm -rf $ZSH_CUSTOM
ln -s $DOTFILES/oh-my-zsh-custom/ $ZSH_CUSTOM

# install plugins
mkdir -p ${ZSH_CUSTOM}/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting

git clone https://github.com/jeffreytse/zsh-vi-mode \
    ${ZSH_CUSTOM}/plugins/zsh-vi-mode

# install zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | zsh

# install starship
if [[ "$USER" == "root" ]]; then
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
fi
ln -s $DOTFILES/.config .config

# vim settings
# install vim package managers
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install dotfiles
test -f $HOME/.vimrc && rm $HOME/.vimrc
ln -s $DOTFILES/.vimrc $HOME/.vimrc

# install Github copilot
git clone https://github.com/github/copilot.vim.git \
  ~/.vim/pack/github/start/copilot.vim

# install charm
if [[ "$USER" == "root" ]]; then
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list
    apt update -y && apt install charm skate mods gum glow
    charm completion zsh > "${fpath[1]}/_charm"
fi

cat << EOF
    # manual setup needed!!!

    # invoke vim plugin managers
    vim +PlugUpdate +qall
    vim +PluginInstall +qall

    # use vim and issue Copilot setup with device authentication
    # setup mods authentication via OPENAI_API_TOKEN
    skate set github.com https://github.com/settings/tokens
    skate set openai.com https://platform.openai.com/api-keys
    export OPENAI_API_KEY=$(skate get openai.com)
    export GITHUB_TOKEN=$(skate get github.com)

    # compile YouCompleteMe
    python3 $HOME/.vim/bundle/YouCompleteMe/install.py --all --force-sudo
EOF

