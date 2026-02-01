# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a flake-based NixOS configuration repository that uses home-manager for user-level package and configuration management. The repository uses a modular architecture where each feature or application has its own Nix module file.

## Essential Commands

### Building and Switching Configurations

```bash
# Build and activate the NixOS configuration (requires sudo)
sudo nixos-rebuild switch

# Build without activating (test build)
sudo nixos-rebuild build

# Build a VM for testing (no sudo required)
nixos-rebuild build-vm
```

### Flake Management

```bash
# Update all flake inputs
nix flake update

# Update a specific input (e.g., nixpkgs)
nix flake lock --update-input nixpkgs

# Check flake for errors
nix flake check
```

### Formatting

```bash
# Format Nix files using nixpkgs-fmt
nixpkgs-fmt **/*.nix

# Format a specific file
nixpkgs-fmt path/to/file.nix
```

## Architecture

### Flake Structure

The flake automatically discovers all hosts from the `hosts/` directory and creates a `nixosSystem` configuration for each one. Each host configuration:

1. Sets `networking.hostName` to the directory name
2. Imports `./hosts/<hostName>/default.nix` for host-specific configuration
3. Imports `./configuration.nix` as the base configuration

### Configuration Hierarchy

```
flake.nix                          # Entry point - auto-discovers hosts
├── configuration.nix              # Base NixOS config - imports all modules
├── home-manager.nix               # Home-manager setup and user packages
└── hosts/<hostname>/              # Per-host configuration
    ├── default.nix                # Host-specific options and hardware imports
    └── hardware-configuration.nix # Auto-generated hardware config
```

### Module Organization

All feature modules are imported in `configuration.nix`. Each module file:
- Defines options under `hostOptions.<feature>`
- Configures the feature when enabled via `hostOptions`
- May import submodules (e.g., `desktop-envs/default.nix` imports GNOME, COSMIC, etc.)

Key module categories:
- **Shells**: `shells/` (bash, fish, zsh with shared aliases in `default.nix`)
- **Desktop environments**: `desktop-envs/` (GNOME, COSMIC)
- **Display managers**: `display-managers/`
- **Terminals**: `terminals/` (kitty, wezterm)
- **Editors**: `helix.nix`, `vscode.nix`, `neovim/`
- **Dev tools**: `dev-tools/` (holochain, etc.)
- **System**: `bootloader.nix` (supports grub, systemd-boot, lanzaboote for Secure Boot)

### Custom Options System

The repository defines custom options under `hostOptions` in `configuration.nix`. Each module can add its own options to this namespace. Host configurations (in `hosts/<hostname>/default.nix`) set these options to enable/configure features.

Example from `hosts/MiFW13/default.nix`:
```nix
hostOptions = {
  userName = "Callum";
  shells.fish.enable = true;
  desktopEnvironments.cosmic.enable = true;
  neovim.enable = true;
};
```

### Home-manager Integration

Home-manager is configured as a NixOS module (not standalone). User configuration is accessed via `home-manager.users.${user}` where `user` comes from `config.hostOptions.user`. The username is derived from `hostOptions.userName` by lowercasing it.

## Flake Inputs

- **nixpkgs**: nixos-unstable channel
- **home-manager**: User environment manager
- **catppuccin**: Theme for various applications
- **lanzaboote**: Secure Boot support
- **neorg-overlay**: Neorg packages for Neovim
- **nixos-hardware**: Hardware-specific configurations
- **pico-8-src**: Local path input (not in nix store)

## Important Conventions

1. **Module pattern**: Each `.nix` file should define options under `hostOptions` and configure services based on those options
2. **User access**: Get the username via `config.hostOptions.user` instead of hardcoding
3. **Shared configuration**: Shell aliases are defined once in `shells/default.nix` for all shells
4. **Conditional imports**: Use `lib.mkIf` to conditionally enable features based on `hostOptions`
5. **Bootloader selection**: Three bootloaders are supported via `hostOptions.bootloader`: "grub", "systemd-boot", or "lanzaboote"
