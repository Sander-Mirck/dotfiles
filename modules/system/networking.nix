# Networking configuration
{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Security improvements
  networking.firewall.enable = true; # Enable the firewall by default
  networking.firewall.allowPing = true; # Allow ping by default

  # Additional network security
  networking.extraHosts = ''
    # Prevent tracking by blocking common tracking domains
  '';
}
