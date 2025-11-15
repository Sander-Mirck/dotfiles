# modules/system/networking.nix
# Networking configuration
{
  config,
  pkgs,
  lib, # <-- Add lib to the arguments
  ...
}: {
  # Set a default hostname that can be overridden by specific hosts.
  networking.hostName = lib.mkDefault "nixos"; # <-- Wrap the value here

  networking.networkmanager.enable = true;

  # Security improvements
  networking.firewall.enable = true; # Enable the firewall by default
  networking.firewall.allowPing = true; # Allow ping by default

  # Additional network security
  networking.extraHosts = ''
    # Prevent tracking by blocking common tracking domains
  '';
}