# Installation Guide

## Step 1 - Setup WSL

Unregister your current Ubuntu distribution and reinstall Ubuntu on the Windows Subsystem for Linux (WSL):

```bash
wsl.exe --unregister Ubuntu
wsl.exe --install Ubuntu
```
## Step2 - Environment Setup

Set the language locale to en_US.UTF-8, update and upgrade existing packages, add Git and Vim PPAs:

```bash
locale-gen en_US.UTF-8
apt update -y && apt upgrade -y
add-apt-repository ppa:git-core/ppa -y
add-apt-repository ppa:jonathonf/vim -y
```

## Step 3 - NodeSource Setup

Download, setup and remove the NodeSource setup script:

```bash
curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh
chmod 500 nsolid_setup_deb.sh
./nsolid_setup_deb.sh 21
rm --force nsolid_setup_deb.sh
```

## Step 4 - Installing base packages

Install base packages like zsh, git, vim, Node.js, Vim-Nox, build-essential, python3-dev, etc:

```bash
apt update && apt install zsh git vim \
    nodejs vim-nox build-essential cmake \
    python3-dev mono-complete openjdk-17-jdk openjdk-17-jre -y
```

## Step 5 - Cloning Repos

Set up the repo paths and clone the dotfiles repo:

```bash
export REPOS=$HOME/repos
export LAIDBACK=github.com/laidback
export DOTFILES=$REPOS/$LAIDBACK/dotfiles
git clone https://$LAIDBACK/dotfiles $DOTFILES
```

## Step 6 - Installing GoLang

Remove any previously installed version of golang and install the updated golang:

```bash
rm -rf /usr/local/go
curl -sLO https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
rm go1.21.5.linux-amd64.tar.gz
GOROOT=/usr/local/go
```
Add the Go path to your system path:

```bash
export PATH=$PATH:/usr/local/go/bin
```

## Step 7 - Customizing Shell

Change your default shell to ZSH:

```bash
chsh -s /bin/zsh $USER
```

## Step 8 - Installing Oh-My-Zsh

Remove any older version of Oh-My-Zsh and install the latest version:

```bash
test -d $HOME/.oh-my-zsh && rm -rf $HOME/.oh-my-zsh
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | zsh
```

## Step 9 - Installing dotfiles

Remove existing .zshrc and link the new .zshrc
Set up a zsh custom directory:

```bash
ln -s $DOTFILES/.zshrc $HOME/.zshrc
export ZSH_CUSTOM=$HOME/oh-my-zsh-custom
ln -s $DOTFILES/oh-my-zsh-custom/ $ZSH_CUSTOM
```

## Step 10 - Installing Plugins

Clone zsh plugins into the custom/plugins directory:

```bash
mkdir -p ${ZSH_CUSTOM}/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM}/plugins/zsh-vi-mode
```

## Step 11 - Installing zoxide and starship

```bash
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | zsh
curl -sS https://starship.rs/install.sh | sh -s -- --yes
```
Link the configuration file:

```bash
ln -s $DOTFILES/.config .config
```

## Step 12 - Vim Setup

Set up the Vim package managers, install the dotfiles, Github copilot and Charm:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s $DOTFILES/.vimrc $HOME/.vimrc
git clone https://github.com/github/copilot.vim.git ~/.vim/pack/github/start/copilot.vim
```

## Step 13 - Charm Setup

Download and install the charm packages:

```bash
mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list
apt update -y && apt install charm skate mods gum glow
charm completion zsh > "${fpath[1]}/_charm"
```

## Step 14 - Manual Setup

Perform additional manual setup, such as updating Vim plugins, setting up mods authentication, and compiling YouCompleteMe:

```bash
vim +PlugUpdate +qall
vim +PluginInstall +qall
skate set github.com https://github.com/settings/tokens
skate set openai.com https://platform.openai.com/api-keys
python3 $HOME/.vim/bundle/YouCompleteMe/install.py --all --force-sudo
```

## Installation Process

### Prerequisites
- Ensure you have `root` user access.

### Docker Installation
1. Update the apt package index and install the appropriate dependencies.
```
   apt-get update
   apt-get install ca-certificates curl gnupg -y
```
2. Get Docker's official GPG key and add the repository to apt sources.
```
   install -m 0755 -d /etc/apt/keyrings
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   chmod a+r /etc/apt/keyrings/docker.gpg
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
```
3. Install Docker.
```
   apt-get update
   apt-get install docker-ce docker-ce-cli containerd.io -y
   sudo groupadd docker
```
4. Add the user to the Docker group.
```
   sudo usermod -aG docker $USER
```

### Kubectl Installation
1. Download kubectl's GPG key and add the repository to apt sources.
```
   curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
   apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
```
2. Install kubectl.
```
   apt-get update
   apt-get install kubectl -y
```

### Helm Installation
1. Add Helm's GPG key and add the repository to apt sources.
```
   curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
   apt-get install apt-transport-https --yes
   echo "deb [arch=$(dpkg --print-architecture)] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
```
2. Install Helm.
```
   apt-get update
   apt-get install helm -y
```

### Krew Installation
1. Install krew.
```
   cd "$(mktemp -d)" &&
   OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
   ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
   KREW="krew-${OS}_${ARCH}" &&
   curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
   tar zxvf "${KREW}.tar.gz" &&
   ./"${KREW}" install krew
```

### Go Tools and Kubernetes Packages Installation
1. Install Go tools and packages.
```
   go install sigs.k8s.io/kind@latest
   go install github.com/stern/stern@latest
```
2. Install flux
```
   curl -s https://fluxcd.io/install.sh | sudo bash
```

### AWS CLI Installation
1. Download, unzip, and install the AWS CLI.
```
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
   rm -rf ./aws
```

### AWS Azure Login Installation
1. Install AWS Azure Login via Node Package Manager.
```
   npm install -g aws-azure-login
```

