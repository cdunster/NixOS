# Global Claude Code Configuration

This file provides general guidance to Claude Code across all projects.

## General Principles

### Code Quality

- Prioritize code clarity and maintainability over cleverness
- Follow existing code style and conventions in each project
- Only refactor when explicitly asked or when necessary for the task at hand

### Communication

- Be very concise, direct, and straight to the point in responses
- Avoid unnecessary emojis unless requested
- Don't make time estimates for tasks

### Tool Usage

- Use specialized tools over bash commands when available
- Run independent commands in parallel when possible
- Never guess or make up tool parameters or options

### Security

- Never add credentials, API keys, or sensitive data to code
- Be careful with git operations - never push or run destructive commands
  unless explicitly requested
- Validate input at system boundaries, but trust internal code

### Git Workflow

- Only create commits when explicitly requested
- Stage specific files rather than using `git add .` or `git add -A`
- Follow the conventional commits guidelines for all commits and keep them as
  small as possible
- Never skip hooks (--no-verify) unless explicitly requested
- Always create new commits rather than amending (unless specifically asked to amend)

### File Operations

- Always read files before editing them
- Prefer editing existing files over creating new ones
- Don't create documentation files unless explicitly requested
- Never write files just to communicate - use text output instead

## Project-Specific Context

When working in a repository, always check for:

- Local CLAUDE.md files with project-specific guidance
- README.md for build/test commands and project overview
- CONTRIBUTING.md for contribution guidelines
- .cursorrules or .github/copilot-instructions.md for additional context
