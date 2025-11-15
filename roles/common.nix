# roles/common.nix
#
# Common settings applied to all systems.
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

  # Basic Nix settings
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;

  # Set the system state version.
  system.stateVersion = "25.05";
}