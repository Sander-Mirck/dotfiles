# /roles/common.nix
# This role defines the base configuration applied to all systems.
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../modules/system/boot.nix
    ../modules/system/locale.nix
    ../modules/system/networking.nix
    ../modules/system/security-performance.nix
    ../modules/system/sudo.nix
    ../modules/system/user-sander.nix
  ];

  # --- New Section to Fix the Error ---
  # Enable the Zsh shell at the system level.
  # This is required by a NixOS safety check when a user's default shell
  # is set to Zsh. It ensures the shell environment is set up correctly.
  programs.zsh.enable = true;
  # ------------------------------------

  # Enable flakes and nix-command features.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow proprietary software.
  nixpkgs.config.allowUnfree = true;

  # Set the system's state version to ensure configuration compatibility.
  system.stateVersion = "25.05";
}
