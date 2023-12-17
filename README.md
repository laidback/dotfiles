# WSL Setup

This repository provides you with scripts that set up the Windows Subsystem for Linux (WSL) on your machine.

## Description
This script essentially does the following:
1. Lists all WSL distros on your Windows machine,
2. Unregisters the default Ubuntu,
3. Re-installs the Ubuntu again,
4. Sets up various useful packages, such as git, vim and zsh,
5. Sets up NodeSource,
6. Installs base packages,
7. Installs Golang,
8. Sets up the dotfile repo,
9. Customizes zsh settings and installs oh-my-zsh,
10. Installs several ZSH plugins,
11. Installs Zoxide,
12. Installs Starship,
13. Sets up vim and installs vim package managers,
14. Installs dotfiles,
15. Compiles YouCompleteMe,
16. Installs Github Copilot,
17. Installs charm and some other packages for charm.

After running the script, you need to manually set up Github Copilot with device authentication and charm.

**Important:** The script assumes that it is executed with the user 'root'. Please make sure of this before executing the script.

## Dependencies
Please ensure the following dependencies are met:
1. Windows Subsystem for Linux (WSL) is installed and Ubuntu distro is setup.
2. A stable internet connection for downloading and installing packages.
3. Ensure that you have the necessary privileges to execute the script and install or uninstall distros and packages.

## Usage
To execute the script, navigate to the directory containing the script. Then, use a command-line interface such as Terminal or Command Prompt to run the script. 

## Caution
Please be aware that this script will unregister and reinstalls Ubuntu again. Also, it captures and downloads software from a variety of sources into your system. Make sure you trust these sources before executing the script.

# Development Environment Setup 

This repository contains a bash script which helps in setting up your development environment. The setup script will specifically help with the installation of Docker and some Kubernetes ecosystem tools.

## Prerequisites 

To use this script, ensure that you have the necessary permissions to execute a bash script and install software in your operating system.

## Usage

To use this script, run the script file in your terminal. The script checks if the user is root, and if true, begins the development environment setup. 

In the setup process, the script:

1. Adds Docker's official GPG key which is used for signing Docker packages.
2. Adds Docker's official repository to Apt sources.
3. Installs Docker, the Docker CLI, and the Containerd runtime.
4. Installs the Kubernetes command-line tool, Kubectl, and other Kubernetes ecosystem tools such as Krew, Kubetail, Stern, Kind, and Flux.

Specifically, the Kubernetes ecosystem tools installed are as follows:

- `kubectl`: A command line tool for controlling Kubernetes clusters.
- `krew`: A tool that makes it easier to use kubectl plugins.
- `kubetail`: A bash script to tail Kubernetes logs from multiple pods at the same time.
- `stern`: A log tailing tool for Kubernetes that combines all logs streams into one.
- `kind`: A tool for running local Kubernetes clusters using Docker container nodes.
- `flux`: A tool for keeping Kubernetes clusters in sync with configuration files.

Following the process, Docker and Kubernetes tools will be set up and ready for use. 

_Note: This script is designed to run on Ubuntu distributions. Running the script on other Linux systems may require modifications._ 

## Support 

For any issues encountered while running this script, we recommend referring to the respective software's official documentation:

- Docker: https://docs.docker.com
- Kubernetes: https://kubernetes.io/docs/home
- Krew: https://krew.sigs.k8s.io/docs/user-guide
- Kubetail: https://github.com/johanhaleby/kubetail
- Stern: https://github.com/stern/stern
- Kind: https://kind.sigs.k8s.io
- Flux: https://fluxcd.io/docs/get-started


