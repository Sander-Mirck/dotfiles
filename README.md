# NixOS Configuration

This is my personal NixOS configuration using flakes.

## Structure

- `flake.nix` - Main flake entry point
- `hosts/nixos/` - Host-specific configuration
- `modules/` - Modular configuration components
  - `home-manager/sander.nix` - My home configuration
  - `system/` - System-level modules

## Usage

```bash
# Apply the system configuration
sudo nixos-rebuild switch --flake .#nixos
```

## License

MIT