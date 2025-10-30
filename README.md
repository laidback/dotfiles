# Installation Guide

## VSCode VIM stuff

````markdown
# Personal Dotfiles

> Lean CLI development environment - Your personal keychain to productive terminal work

## What This Is

Personal dotfiles for cross-platform CLI development (macOS/WSL2/Linux). Foundation for the [DevOps Copilot Framework](https://git.buts.hilti.cloud/ci24/devops-copilot).

**Core Philosophy**: Everything you need in a container. The Dockerfile is the single source of truth.

## Quick Start

```bash
# Clone
export REPOS="${HOME}/repos"
export LAIDBACK="github.com/laidback"
mkdir -p "${REPOS}/${LAIDBACK}"
git clone "https://${LAIDBACK}/dotfiles" "${REPOS}/${LAIDBACK}/dotfiles"
cd "${REPOS}/${LAIDBACK}/dotfiles"

# Setup (requires root)
sudo ./01-setup_dev_vm.sh      # Base: shell, vim, languages
./02-setup_dev_env.sh          # DevOps: docker, k8s, cloud tools

# Or use Docker
docker build -t dotfiles .
docker run -it dotfiles
```

## What's Inside

**Core Files**:
- `.zshrc` - Zsh config with vi-mode, starship, smart completions
- `.vimrc` - Vim config with plugins and GitHub Copilot
- `.wslconfig` - WSL2 tuning (16GB RAM, 2 CPUs)
- `Dockerfile` - Complete dev environment in a container

**Shell** (Zsh):
- Starship prompt + zoxide + vi-mode (`jk` to escape)
- Auto-suggestions, syntax highlighting
- kubectl, helm, flux completions
- Git aliases: `gap` (add/commit/push), `gcc` (branch/commit), `glog` (pretty log)

**Vim**:
- Vundle + vim-plug for plugins
- NERDTree, syntastic, vim-fugitive, vim-airline
- GitHub Copilot ready
- Leader key: `<Space>`

**DevOps Stack**:
- Docker, kubectl, helm, krew, flux, kustomize
- kind, stern, glab (GitLab CLI)
- AWS CLI with completions
- Go 1.21.5, Node.js 21, Java 21 LTS, Python 3

**AI Tools**:
- Charm: gum, mods, skate, glow
- GitHub Copilot (vim + VS Code)
- Custom chatmodes in `github/` directory## VS Code (Private Config)

**Note**: VS Code settings in `vscode/` are templates. Keep your personal settings private:

```bash
# Option 1: Git ignore your personal VS Code config
echo "vscode/settings.local.json" >> .git/info/exclude

# Option 2: Use a private repo for VS Code settings
# Keep vscode/ templates here, actual config in private repo
```

**VS Code Integration**:
- Full `.vimrc` support via vim extension
- GitHub Copilot + MCP (Model Context Protocol) enabled
- Kubernetes tools with macOS ARM64 paths pre-configured
- Terminal auto-approve for git/npm commands

## Manual Steps (After Automated Setup)

```bash
# 1. Vim plugins
vim +PlugUpdate +qall && vim +PluginInstall +qall

# 2. GitHub Copilot (in vim)
# :Copilot setup

# 3. API keys (using Charm skate)
skate set github.com <YOUR_TOKEN>
skate set openai.com <YOUR_KEY>

# 4. YouCompleteMe (optional)
python3 ~/.vim/bundle/YouCompleteMe/install.py --all
```

```
// Place your key bindings in this file to override the defaults
[{
    "key": "ctrl+l",
    "command": "workbench.action.focusActiveEditorGroup",
    "when": "explorerViewletFocus"
},
{
    "key": "ctrl+k",
    "command": "workbench.action.focusActiveEditorGroup",
},
{
    "key": "ctrl+j",
    "command": "workbench.action.terminal.focus",
    "when": "terminalFocus"
},
{
    "key": "ctrl+z",
    "command": "workbench.action.toggleMaximizedPanel",
    "when": "terminalFocus"
}]
```

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

### Add Charm to Systemd

see: https://github.com/charmbracelet/charm/blob/main/systemd.md

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

### Add Docker to Systemd

see: https://github.com/moby/moby/blob/master/contrib/init/systemd

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

## File Structure

```
dotfiles/
├── Dockerfile                  # Complete dev environment
├── 01-setup_dev_vm.sh         # Base: zsh, vim, Go, Node, Java
├── 02-setup_dev_env.sh        # DevOps: docker, k8s, cloud
├── .zshrc                     # Shell config
├── .vimrc                     # Vim config
├── .wslconfig                 # WSL2 tuning
├── vscode/                    # VS Code templates (keep private!)
├── github/                    # AI chatmodes & instructions
└── oh-my-zsh-custom/          # Shell theme & customizations
```

## Keeping VS Code Settings Private

Your VS Code config often contains personal tokens, workspace paths, and preferences. Here's how to handle it:

### Option 1: Git Info Exclude (Recommended)
```bash
# Keep in repo but don't commit changes
echo "vscode/settings.local.json" >> .git/info/exclude
echo "vscode/*.local.*" >> .git/info/exclude
```

### Option 2: Separate Private Repo
```bash
# Keep dotfiles public, VS Code settings private
# In dotfiles: Only templates
# In private repo: Your actual settings
```

### Option 3: Environment-Specific Configs
```bash
vscode/
├── settings.json              # Template (commit this)
├── settings.local.json        # Your personal settings (gitignored)
└── keybindings.json           # Safe to commit (no secrets)
```

## The Dockerfile Approach

Everything in the setup scripts can run in a container:

```dockerfile
# See Dockerfile for full setup
docker build -t dotfiles .
docker run -it dotfiles

# Your entire dev environment, portable
```

**Why containerize?**:
- Consistent environment across machines
- Test setup scripts safely
- Share dev environment with team
- Fast machine onboarding

## Advanced Configuration

### Cross-Platform Support

#### macOS-specific

```bash
# Colima for Docker (macOS alternative to Docker Desktop)
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

# Homebrew-managed Go installation
export GOROOT=$(brew --prefix golang)/libexec
```

#### WSL2-specific

- Memory: 16GB allocated (`.wslconfig`)
- Networking: NAT mode with DNS tunneling
- Integration: systemd boot commands for KVM permissions

### Kubernetes Workflows

```bash
# Switch between kubeconfig files interactively
ktx

# Switch namespace in current context
kns

# View logs across multiple pods
stern <pod-name-pattern>

# Quick cluster creation with kind
kind create cluster --name dev
```

### Git Workflows

```bash
# Add all, commit with prompt, and push
gap

# Create branch, add all, commit with prompts
gcc

# Pretty git log with colors
glog
```

## Manual Setup Steps

After automated installation, perform these steps:

### 1. Vim Plugins

```bash
vim +PlugUpdate +qall
vim +PluginInstall +qall
```

### 2. GitHub Copilot Authentication

```bash
vim
# Inside vim, run: :Copilot setup
```

### 3. API Keys Setup (using Charm Skate)

```bash
skate set github.com <YOUR_GITHUB_TOKEN>
skate set openai.com <YOUR_OPENAI_KEY>

export GITHUB_TOKEN=$(skate get github.com)
export OPENAI_API_KEY=$(skate get openai.com)
```

### 4. YouCompleteMe Compilation

```bash
python3 ~/.vim/bundle/YouCompleteMe/install.py --all --force-sudo
```

### 5. Systemd Integration (Optional)

- [Charm systemd setup](https://github.com/charmbracelet/charm/blob/main/systemd.md)
- [Docker systemd setup](https://github.com/moby/moby/blob/master/contrib/init/systemd)

## Repository Structure

```
dotfiles/
├── 01-setup_dev_vm.sh         # Base system + shell setup
├── 02-setup_dev_env.sh         # Development tools installation
├── .zshrc                      # Zsh configuration
├── .vimrc                      # Vim configuration
├── .wslconfig                  # WSL2 settings
├── .config/                    # Application configs
│   └── starship.toml          # Starship prompt config
├── .github/                    # GitHub-specific configs
│   └── copilot-instructions.md # AI coding guidelines
├── github/                     # AI chatmodes & instructions
│   ├── chatmodes/             # AI persona definitions
│   ├── instructions/          # Coding standards
│   └── prompts/               # Task templates
├── oh-my-zsh-custom/          # Zsh customizations
│   ├── plugins/               # Additional plugins
│   └── themes/                # Custom themes
├── templates/                  # Project templates
│   ├── .gitlab-ci.yml         # CI/CD template
│   └── .releaserc.json        # Semantic release config
└── vscode/                     # VS Code templates
    ├── settings.json          # Editor preferences
    └── keybindings.json       # Custom keybindings
```

## Integration with DevOps Copilot

This repository serves as the base configuration layer for the [DevOps Copilot Framework](https://git.buts.hilti.cloud/ci24/devops-copilot), providing:

- **Consistent Environment**: Shared shell, editor, and tool configurations
- **AI Instructions**: Reusable chatmodes and coding standards
- **Automation Scripts**: Template-based repository initialization
- **Tool Chain**: Common DevOps utilities across all projects

## Additional Tools (Optional)

For enhanced security and networking capabilities:

- **Mullvad VPN**: Client and CLI for secure connections
- **IPFS**: Distributed file system
- **iperf3**: Network performance measurement
- **shadowsocks**: Secure tunneling

## Resources

- [Oh My Zsh](https://ohmyz.sh/)
- [Starship Prompt](https://starship.rs/)
- [GitHub Copilot](https://github.com/features/copilot)
- [Charm Tools](https://charm.sh/)
- [Proto School](https://proto.school/) - Learn web3 protocols

---

**License**: MIT
**Maintained by**: [@laidback](https://github.com/laidback)

````
