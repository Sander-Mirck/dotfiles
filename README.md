# NixOS Configuration

This is my personal NixOS configuration using flakes.
I'm looking to switch to hyprland in the future (I have used it a long time before, but it wasn't stable and needed to use this laptop for my study). If I have some time then I'll look into switching. I'll keep this gnome based version in a seperate branch, but I'll won't be updating it then. But I will be sticking to this configuration for a while. 

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