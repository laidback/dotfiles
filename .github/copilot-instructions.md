---
description: "Personal dotfiles repository - Cross-platform development environment configuration and automation for DevOps workflows with AI-assisted development"
applyTo: "**/*"
---

# AI Coding Instructions for Personal Dotfiles Repository

## Repository Context

### Purpose & Scope

Personal development environment configuration repository serving as the **foundational layer** for all internal repositories, particularly the DevOps Copilot Framework.

**Repository Type**: Dotfiles (cross-platform: macOS/WSL2/Linux)
**Last Updated**: October 2025
**Technologies**: Bash, Zsh, Vim, VS Code, Docker, Kubernetes, Go, Node.js, Java 21 LTS

**Core Focus**:
- Cross-platform dotfiles (macOS/WSL2/Linux)
- VS Code workspace and MCP (Model Context Protocol) integration
- AI coding assistance configuration (GitHub Copilot, chatmodes)
- Development environment automation scripts
- DevOps toolchain standardization

### Technology Stack

- **Shell**: Zsh with Oh-My-Zsh, Starship prompt, vi-mode
- **Editors**: Vim (with Vundle/vim-plug), VS Code (with Copilot)
- **Languages**: Bash, Go 1.21.5, Node.js 21+, Python 3, Java 21 LTS
- **DevOps**: Docker, Kubernetes (kubectl, helm, krew, flux), AWS CLI
- **AI Tools**: GitHub Copilot, Charm tools (gum, mods, skate, glow)

## Architecture & Key Components

### Configuration Management Structure

```
dotfiles/
├── vscode/           # VS Code configuration templates
│   ├── mcp.json     # MCP server connections
│   └── settings.json # Editor preferences with vim/k8s tools
├── github/          # AI instruction templates and modes
│   ├── instructions/ # Targeted AI coding guidelines
│   ├── chatmodes/   # AI persona configurations
│   └── prompts/     # Task-specific AI prompts
├── oh-my-zsh-custom/ # Shell customizations
└── *.sh            # Environment setup automation
```

### MCP Integration Points

- **VS Code Integration**: MCP enabled via `chat.mcp.enabled: true` in settings
- **Server Configuration**: `vscode/mcp.json` defines external service connections
- **Atlassian Connection**: SSE-based connection to `mcp.atlassian.com/v1/sse`

## Critical Workflows

### Environment Setup (WSL2/Linux)

```bash
# Initial VM setup (requires root)
./01-setup_dev_vm.sh
# Development environment (Docker, kubectl, Node.js)
./02-setup_dev_env.sh
```

### VS Code Configuration Deployment

1. Copy `vscode/*.json` to appropriate VS Code settings directory
2. MCP servers auto-connect on workspace open
3. AI instructions apply globally via frontmatter patterns

## Project-Specific Conventions

### AI Instruction Files

- **Global scope**: Uses `applyTo: "**"` frontmatter pattern
- **File structure**: `*.instructions.md` for rules, `*.chatmode.md` for personas
- **Mandatory footer**: All AI-generated files must end with `<!-- Contains AI-generated edits. -->`

### Shell Environment

- **Theme**: Custom `lc-magic.zsh-theme` with git integration
- **Plugins**: Auto-suggestions, syntax highlighting, vi-mode
- **Vim integration**: `.vimrc` linked via VS Code vim extension

### Container & K8s Tools

- **Docker**: Automated installation with user group management
- **kubectl**: Google Cloud packages repository
- **VS Code extensions**: Kubernetes tools with predefined paths for macOS ARM64

## Development Patterns

### Configuration File Management

- Templates in `vscode/` directory for cross-machine deployment
- Separate user-specific settings in VS Code User directory
- MCP configuration supports environment-specific server URLs

### AI Mode Selection Strategy

- `lc-architect.chatmode.md`: System design and architectural decisions
- `reviewer.chatmode.md`: Code quality and review processes
- `senior-dev.chatmode.md`: Implementation guidance and best practices

### Setup Script Patterns

- Root privilege detection: `[[ "$USER" == "root" ]]`
- Conditional package installation based on user context
- Repository addition before package installation (PPAs, Docker, K8s)

## Integration Points

### External Dependencies

- **Node.js**: NodeSource repository (version 21+)
- **Docker**: Official Docker CE repository
- **Kubernetes**: Google Cloud packages for kubectl
- **Atlassian MCP**: Cloud service integration for project management

### Cross-Platform Considerations

- WSL2 configuration via `.wslconfig` and `etc/wsl.conf`
- macOS-specific paths for Kubernetes tools in VS Code settings
- Platform-agnostic shell configuration with oh-my-zsh

## Team Conventions

When working with this repository:
- All shell scripts should handle both root and user contexts
- VS Code settings are templates - customize for local needs
- MCP configurations may require service-specific authentication
- Maintain compatibility across WSL2, Linux, and macOS environments

<!-- Contains AI-generated edits. -->
