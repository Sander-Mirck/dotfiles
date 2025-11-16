# My NixOS Configuration

Modular NixOS configuration with flakes and Home Manager.

## Quick Start

**For daily use, use the `stable` branch.** The `unstable` branch is for active development and may contain breaking changes.

| Branch | Use Case | Command |
|--------|----------|---------|
| **`stable`** | Daily use (recommended) | `nix flake init -t github:Sander-Mirck/dotfiles/stable` |
| **`unstable`** | Development/testing | `nix flake init -t github:Sander-Mirck/dotfiles/unstable` |

The `stable` branch is updated via pull request when changes are tested and ready.

## Repository Structure

- `flake.nix`: Main entry point
- `hosts/`: Machine-specific configs (`laptop`, `server`)
- `profiles/`: Reusable configuration sets (`desktop`, `dev`)
- `modules/`: Custom NixOS & Home Manager modules
- `overlays/`: Package customizations
- `secrets/`: Encrypted secrets (agenix)
- `templates/`: Host templates

## Usage

After initializing from your chosen branch:

```bash
cd /path/to/your/nixos-config
sudo nixos-rebuild switch --flake .#laptop
```
