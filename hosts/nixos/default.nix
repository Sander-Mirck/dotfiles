# /etc/nixos/hosts/nixos/default.nix
#
# This is the main configuration file for the 'nixos' host.
# It imports all the modules and sets host-specific options.

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # Import the hardware configuration for this specific machine.
    ./hardware-configuration.nix

    # Import system-wide modules.
    ../../modules/system/boot.nix
    ../../modules/system/networking.nix
    ../../modules/system/locale.nix
    ../../modules/system/audio.nix
    ../../modules/system/packages.nix
    ../../modules/system/services.nix
    ../../modules/system/sudo.nix
    ../../modules/system/user-sander.nix # System-level user definition
    ../../modules/system/virtualisation.nix
    ../../modules/system/security-performance.nix
    ../../modules/system/shell-aliases.nix
    # Import Home Manager modules.
    inputs.home-manager.nixosModules.home-manager
  ];

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System state version
  system.stateVersion = "25.05";

}