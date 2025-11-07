# NixOS Configuration

This is my personal NixOS configuration, managed with flakes. It sets up my complete system environment declaratively.

## Overview

This configuration manages:
- System packages and services
- Desktop environment (GNOME)
- User settings and packages
- Development tools
- Security settings

## Structure

```
├── flake.nix                 # Main flake entry point
├── flake.lock               # Lock file for reproducible builds
├── .gitignore              # Files to ignore in git
├── hosts/                  # Host-specific configurations
│   └── nixos/              # Configuration for 'nixos' host
│       ├── default.nix     # Main host configuration
│       └── hardware-configuration.nix  # Auto-generated hardware config
├── modules/                # Modular configuration components
│   ├── home-manager/       # Home Manager modules
│   │   └── sander.nix      # My home configuration
│   └── system/             # System-level modules
│       ├── boot.nix        # Boot configuration
│       ├── networking.nix  # Networking settings
│       ├── locale.nix      # Timezone and locale
│       ├── audio.nix       # Audio settings
│       ├── packages.nix    # System packages
│       ├── services.nix    # System services
│       └── user-sander.nix # User configuration
└── overlays/               # Nixpkgs overlays
    └── default.nix
```

## Important Notes

1. **Hardware-specific information**: The `hardware-configuration.nix` file contains system-specific details like disk UUIDs. You'll need to regenerate this file if deploying on different hardware.

2. **Personal information**: This configuration contains my personal information (name, email). You'll likely want to modify these values when using this as a template.

3. **Security considerations**: 
   - No actual passwords, API keys, or sensitive data are stored in plaintext
   - Secrets should be managed separately using tools like sops-nix or agenix if needed
   - Firewall is enabled by default
   - Password requirements are set for user accounts

## Prerequisites

- NixOS 24.05 or later
- Nix with flakes enabled
- Git

## Usage

To apply this configuration:

```bash
# Apply the system configuration (requires root)
sudo nixos-rebuild switch --flake .#nixos
```

To update packages and system:

```bash
# Update flake inputs
nix flake update

# Rebuild with updated packages
sudo nixos-rebuild switch --flake .#nixos --upgrade
```

## Common Commands

- `nrs`: `sudo nixos-rebuild switch --flake /etc/nixos#nixos`
- `nrsu`: `sudo nixos-rebuild switch --upgrade --flake /etc/nixos#nixos`
- `nrb`: `sudo nixos-rebuild boot --flake /etc/nixos#nixos`
- `nrt`: `sudo nixos-rebuild test --flake /etc/nixos#nixos`
- `nrgc`: `sudo nix-collect-garbage -d`
- `nix-update`: `sudo nixos-rebuild switch --flake /etc/nixos#nixos --upgrade`

## Services

This configuration enables:
- GNOME desktop environment
- NetworkManager for networking
- PipeWire for audio
- Tailscale for VPN
- Printing services
- Flatpak support
- Automatic security updates

## Custom Packages

System packages include:
- Development tools and editors
- Communication tools
- Multimedia applications
- System utilities

## License

This configuration is provided as-is, without warranty of any kind. Feel free to use and modify for your own setup.