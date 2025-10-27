# /etc/nixos/hosts/nixos/services.nix
# System services
{ pkgs, ... }:

{
  # X11 + GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb.layout = "us";

  # Printing
  services.printing.enable = true;

  # Enable Docker service
  virtualisation.docker.enable = true;

  # Enable Flatpak system-wide.
  # This automatically handles making Flatpak apps visible in GNOME.
  services.flatpak.enable = true;

  # Enable the Tailscale service
  services.tailscale.enable = true;

  # Enable the Netbird service
  services.netbird.enable = true;
}