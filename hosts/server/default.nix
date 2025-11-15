# hosts/server/default.nix
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Import the common role.
    # A server typically doesn't need the full desktop role.
    ../../roles/common.nix
  ];

  # Server-specific settings.
  networking.hostName = "server";

  # Disable unfree packages for servers.
  nixpkgs.config.allowUnfree = false;
}