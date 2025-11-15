{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../modules/system/boot.nix
    ../modules/system/networking.nix
    ../modules/system/locale.nix
    ../modules/system/security-performance.nix
  ];

  nixpkgs.config.allowUnfree = false;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  system.stateVersion = "25.05";
}
