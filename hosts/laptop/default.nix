# hosts/laptop/default.nix
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Import hardware-specific configuration.
    ./hardware-configuration.nix

    # Import the roles that define this machine.
    ../../roles/desktop.nix
    ../../roles/dev.nix
  ];

  # Host-specific settings can go here.
  networking.hostName = "laptop";
}