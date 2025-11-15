# NixOS Configuration

This repository contains my modular NixOS configuration using flakes, profiles, overlays, and secrets.

## Structure
- `flake.nix` – Main entry point
- `hosts/` – Machine-specific configs
- `profiles/` – Reusable bundles (workstation, server, gaming)
- `modules/` – System and Home Manager modules
- `overlays/` – Package customizations
- `secrets/` – Encrypted secrets (via agenix)
- `templates/` – Starter configs for new hosts

## Usage
```bash
# Apply config for laptop
sudo nixos-rebuild switch --flake .#laptop

# Apply config for server
sudo nixos-rebuild switch --flake .#server
