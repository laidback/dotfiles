# AI Coding Instructions for Workspaces Configuration Repository

## Project Overview

This is a configuration management repository for AI development tools, primarily focused on GitHub Copilot, MCP (Model Context Protocol) servers, and VS Code workspace settings. The repository serves as a centralized hub for AI coding standards and development environment configurations.

## Architecture & Key Components

### MCP Server Configuration

- **Primary config**: `.vscode/mcp.json` defines server connections
- **Internal GitLab**: Uses custom API endpoint `git.buts.hilti.cloud/api/v4`
- **Token management**: Environment variables via VS Code input prompts
- **Server types**: Mixed stdio (npx commands) and HTTP (SSE) connections

### AI Instructions Hierarchy

1. **Global**: `.vscode/copilot-instructions.md` - applies to all files
2. **Targeted**: `.github/instructions/*.instructions.md` - specific patterns
3. **Context-aware**: `.github/chatmodes/*.chatmode.md` - persona-based interactions

## Critical Workflows

### MCP Server Setup

```bash
# Use the provided setup script
./scripts/setup.sh
# This installs: @playwright/mcp, @zereight/mcp-gitlab, @azure/mcp
```

### Token Configuration

- GitLab tokens are prompted via VS Code inputs (see `mcp.json` inputs section)
- Never hardcode tokens - always use `${input:token-name}` pattern
- Token descriptions should clearly indicate the service and permissions needed

## Project-Specific Conventions

### File Naming Patterns

- Instructions: `*.instructions.md` with frontmatter `applyTo: "**"`
- Chat modes: `*.chatmode.md` with model and tools specification
- Prompts: `*.prompt.md` with mode and requirements metadata

### Frontmatter Standards

```markdown
---
applyTo: '**' # For instructions
model: Claude Sonnet 4 # For chatmodes
mode: 'agent' # For prompts
---
```

### Mandatory AI Edit Markers

- All AI-generated files must end with: `<!-- Contains AI-generated edits. -->`
- This is enforced by `base.instructions.md` global rule

## Integration Points

### VS Code Workspace Configuration

- Multi-root workspace: `workspaces.code-workspace` and `wfm.code-workspace`
- MCP integration automatically loads on workspace open
- Copilot instructions are globally applied via `.vscode/` directory

### External Dependencies

- **Hilti Internal GitLab**: `git.buts.hilti.cloud` (requires VPN/internal network)
- **Atlassian Cloud**: SSE connection to `mcp.atlassian.com`
- **Azure Services**: Latest MCP server for cloud resource management
- **Playwright**: Browser automation via MCP interface

## Development Patterns

### Configuration File Updates

- When modifying `mcp.json`, validate JSON syntax and test server connections
- Always update corresponding documentation in `README.md`
- Use `npx` commands for portable MCP server execution

### AI Mode Selection

- Use `architect.chatmode.md` for system design discussions
- Use `reviewer.chatmode.md` for code quality assessments
- Use `senior-dev.chatmode.md` for implementation guidance

### Prompt Template Usage

- Reference specific prompts via `@prompts/filename.prompt.md`
- Templates include requirements for TypeScript, error handling, and testing
- Follow conventional commits and semantic release practices

## Team Conventions

- **Commit format**: Conventional commits (`feat:`, `fix:`, `docs:`, etc.)
- **Branch naming**: `feature/[ticket-id]-[description]`, `bugfix/`, `hotfix/`
- **Error handling**: Always implement try/catch for async operations
- **Naming**: PascalCase for types/interfaces, camelCase for functions/variables

## Quick Reference Commands

```bash
# Test MCP connection
npx @zereight/mcp-gitlab --version

# Validate workspace configuration
code --list-extensions | grep copilot

# Reload VS Code window to apply new MCP configs
# Command Palette > "Developer: Reload Window"
```

<!-- Contains AI-generated edits. -->
