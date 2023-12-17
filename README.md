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

