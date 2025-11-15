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

  # Journald limits
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFileSize=10M
  '';

  # Generic portal support (desktop-specific portals are handled in your desktop module)
  xdg.portal.enable = true;
}
