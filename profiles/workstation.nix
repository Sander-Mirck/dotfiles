{ config, pkgs, lib, ... }:
{
  imports = [
    ../modules/system/boot.nix
    ../modules/system/networking.nix
    ../modules/system/locale.nix
    ../modules/system/audio.nix
    ../modules/system/packages.nix
    ../modules/system/services.nix
    ../modules/system/sudo.nix
    ../modules/system/user-sander.nix
    ../modules/system/virtualisation.nix
    ../modules/system/security-performance.nix
    ../modules/system/shell-aliases.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";
}
