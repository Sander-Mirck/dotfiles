# /etc/nixos/hosts/nixos/services.nix
# System services
{
  pkgs,
  lib,
  ...
}: {
  # X11 + GNOME (GDM defaults to Wayland; Xorg as fallback)
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb.layout = "us";

  # Printing
  services.printing.enable = true;

  # Flatpak system-wide.
  services.flatpak.enable = true;

  # Network mesh/VPNs
  services.tailscale.enable = true;
  services.netbird.enable = true;

  # Keyring & storage
  services.gnome.gnome-keyring.enable = true;
  services.udisks2.enable = true;

  # Journald limits
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=10M
  '';

  # Use GNOME's portal backend (better with Mutter/Wayland than gtk fallback)
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
  };
}
