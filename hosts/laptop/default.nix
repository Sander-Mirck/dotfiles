# /etc/nixos/hosts/nixos/default.nix
#
# Main configuration file for the 'nixos' host.
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Hardware configuration for this machine.
    ./hardware-configuration.nix

    # System-wide modules.
    ../../modules/system/boot.nix
    ../../modules/system/networking.nix
    ../../modules/system/locale.nix
    ../../modules/system/audio.nix
    ../../modules/system/packages.nix
    ../../modules/system/services.nix
    ../../modules/system/sudo.nix
    ../../modules/system/user-sander.nix
    ../../modules/system/virtualisation.nix
    ../../modules/system/security-performance.nix
    ../../modules/system/shell-aliases.nix

    # Do NOT import Home Manager here; it is imported at the flake top-level.
  ];

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Keep this pinned to the release you installed against.
  system.stateVersion = "25.05";
}
