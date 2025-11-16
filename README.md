# My NixOS Configuration

Modular NixOS configuration with flakes and Home Manager.

## Quick Start

**For daily use, always use a stable release.** The `main` branch is for active development and may break.

### Stable Release (Recommended)

Stable releases are source code archives from GitHub Releases:

1. Download the **latest** release: `https://github.com/Sander-Mirck/dotfiles/archive/refs/tags/v0.3.8.zip`
2. Unzip and `cd` into the directory
3. Run: `nix flake init -t .#laptop`

New releases are published weekly. **Always check [GitHub Releases](https://github.com/Sander-Mirck/dotfiles/releases) for the latest version**—the URL above may be outdated.

### Development Build
For testing/contributing: `nix flake init -t github:Sander-Mirck/dotfiles`

## Repository Structure

- `flake.nix`: Main entry point
- `hosts/`: Machine configs (`laptop`, `server`)
- `profiles/`: Reusable sets (`desktop`, `dev`)
- `modules/`: Custom NixOS & Home Manager
- `overlays/`: Package customizations
- `secrets/`: Encrypted secrets (agenix)
- `templates/`: Host templates

## Usage

```bash
cd dotfiles-[version]
sudo nixos-rebuild switch --flake .#laptop
```

## Recent Releases

- **v0.3.2 "Plasma Stable"**: KDE Plasma 6 + cleanup
- **v0.3.1**: First modular release
- **v0.3.0**: Initial structure
