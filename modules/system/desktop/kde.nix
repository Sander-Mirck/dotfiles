# modules/system/desktop/kde.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  # Enable the X server and SDDM display manager
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  # Enable the KDE Plasma 6 desktop environment
  services.desktopManager.plasma6.enable = true;

  # Install some common KDE apps system-wide
  environment.systemPackages = with pkgs; [
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.okular
  ];
}
