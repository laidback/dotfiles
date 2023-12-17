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
    apt update -y && apt upgrade -y
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
        python3-dev mono-complete openjdk-17-jdk openjdk-17-jre -y
fi

REPOS=$HOME/repos

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

# setup dotfile repo
LAIDBACK=github.com/laidback
DOTFILES=$REPOS/$LAIDBACK/dotfiles
mkdir -p $REPOS/$LAIDBACK
git clone https://$LAIDBACK/dotfiles $DOTFILES

# zsh settings
chsh -s /bin/zsh $USER

# install oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | zsh
test -f $HOME/.zshrc && rm $HOME/.zshrc
ln -s $DOTFILES/.zshrc $HOME/.zshrc
ln -s $DOTFILES/oh-my-zsh-custom oh-my-zsh-custom

# install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
    ${ZSH_CUSTOM:-~/oh-my-zsh-custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    ${ZSH_CUSTOM:-~/oh-my-zsh-custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/jeffreytse/zsh-vi-mode \
    ${ZSH_CUSTOM:-~/oh-my-zsh-custom}/plugins/zsh-vi-mode

# install zoxide
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | zsh

# install starship
curl -sS https://starship.rs/install.sh | sh -s -- --yes
ln -s $DOTFILES/.config .config

# vim settings
# install vim package managers
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# invoke vim plugin managers
yes | vim +PlugUpdate +qall
yes | vim +PluginInstall +qall

# install dotfiles
test -f $HOME/.vimrc && rm $HOME/.vimrc
ln -s $DOTFILES/.vimrc $HOME/.vimrc

# compile YouCompleteMe
python3 .vim/bundle/YouCompleteMe/install.py --force-sudo

# install Github copilot
git clone https://github.com/github/copilot.vim.git \
  ~/.vim/pack/github/start/copilot.vim

# install charm
if [[ "$USER" == "root" ]]; then
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
    echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list
    apt update -y && apt install charm skate mods gum glow
fi

charm completion zsh > "${fpath[1]}/_charm"

cat << EOF
    # manual setup needed!!!
    # use vim and issue Copilot setup with device authentication
    #
    # manual setup needed for charm!!!
    charm cloud setup"
    skate set github.com https://github.com/settings/tokens
    skate set openai.com https://platform.openai.com/api-keys
    export OPENAI_API_KEY=$(skate get lukas@api.openai.com)
EOF

