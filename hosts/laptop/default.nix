# /hosts/laptop/default.nix
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Import the auto-generated hardware configuration.
    ./hardware-configuration.nix

    # Assign roles to this host to build its functionality.
    ../../roles/desktop.nix
    ../../roles/dev.nix
  ];

  # Set the hostname for this specific machine.
  networking.hostName = "laptop";
}
