{
  pkgs,
  lib,
  ...
}:
{
  # Printing
  services.printing.enable = true;

  # Flatpak system-wide
  services.flatpak.enable = true;

  # Network mesh/VPNs
  services.tailscale.enable = true;

  # Keyring & storage
  services.udisks2.enable = true;

  # Enable the GNOME Keyring daemon.
  # This provides a secrets service that libsecret (used by Git) can
  # communicate with, resolving credential issues in GUI apps like Zed.
  services.gnome.gnome-keyring.enable = true;

  # Journald limits
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=10M
  '';

  # Generic portal support (desktop-specific portals are handled in your desktop module)
  xdg.portal.enable = true;
}
