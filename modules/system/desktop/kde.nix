{
  config,
  pkgs,
  lib,
  ...
}: {
  services.xserver.enable = true;

  # Use SDDM as display manager
  services.displayManager.sddm.enable = true;

  # Disable GDM to avoid conflicts
  services.displayManager.gdm.enable = lib.mkForce false;

  # Enable KDE Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Optional: add common KDE apps
  environment.systemPackages = with pkgs; [
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.okular
  ];
}
