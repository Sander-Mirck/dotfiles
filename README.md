# NixOS Configuration

This repository contains my modular NixOS configuration using flakes, profiles, overlays, and secrets.

## ⚠️ Important Usage Notice

**Do NOT clone the main branch directly.** This configuration is actively developed and the main branch may be unstable.

**Instead, use one of these stable options:**

### Option 1: Use a Release (Recommended)
```bash
# Download and use a specific release
nix flake init -t github:Sander-Mirck/dotfiles#laptop
```

### Option 2: Use a Stable Tag
```bash
# Use the latest stable tag
nix flake init -t github:Sander-Mirck/dotfiles/v0.3.2#laptop
```

### Option 3: Pin to a Specific Commit
```bash
# Pin to a known working commit
nix flake init -t github:Sander-Mirck/dotfiles/<commit-hash>#laptop
```

## Structure
- `flake.nix` – Main entry point
- `hosts/` – Machine-specific configs  
- `profiles/` – Reusable bundles (workstation, server, gaming)
- `modules/` – System and Home Manager modules
- `overlays/` – Package customizations
- `secrets/` – Encrypted secrets (via agenix)
- `templates/` – Starter configs for new hosts

## Usage
After initializing with a stable release/tag:

```bash
# Apply config for laptop
sudo nixos-rebuild switch --flake .#laptop

# Apply config for server  
sudo nixos-rebuild switch --flake .#server
```

## Stable Releases
- **v0.3.2 "Plasma Stable"** - KDE Plasma 6 & configuration cleanup
- **v0.3.1** - Initial stable release with modular structure
- **v0.3.0** - Base modular configuration

Check the [Releases page](https://github.com/Sander-Mirck/dotfiles/releases) for the latest stable versions.
