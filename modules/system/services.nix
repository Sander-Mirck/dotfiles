# /etc/nixos/hosts/nixos/services.nix
# System services
{ pkgs, ... }:

{
  # X11 + GNOME
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb.layout = "us";

  # Printing
  services.printing.enable = true;

  # Enable Flatpak system-wide.
  # This automatically handles making Flatpak apps visible in GNOME.
  services.flatpak.enable = true;

  # Enable the Tailscale service
  services.tailscale.enable = true;

  # Enable the Netbird service
  services.netbird.enable = true;
  
  # Security and system services
  services.gnome.gnome-keyring.enable = true;  # Enable keyring for password management
  services.udisks2.enable = true;  # Enable automatic mounting of removable media
  
  # Better logging
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=10M
  '';
}