{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/workstation.nix
  ];

  system.stateVersion = "25.05";
}
