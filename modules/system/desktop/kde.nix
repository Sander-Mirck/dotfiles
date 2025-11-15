# modules/system/desktop/kde.nix
{ config, pkgs, lib, ... }:

{
  # Install KDE applications globally
  environment.systemPackages = with pkgs; [
    konsole
    dolphin
    kate
    okular
    gwenview
  ];

  # Enable KDE Plasma desktop
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };
}
