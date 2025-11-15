# modules/system/desktop/kde.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  # Enable the X server
  services.xserver.enable = true;

  # Configure the SDDM display manager
  services.displayManager.sddm = {
    enable = true;
    theme = "breeze";
    settings = {
      Theme = {
        background = "/home/sander/Pictures/wallpapers/nix-wallpaper-binary-black_8k.png";
      };
    };
  };

  # Enable the KDE Plasma 6 desktop environment
  services.desktopManager.plasma6 = {
    enable = true;

    # Add this line to disable KDE's automatic GTK configuration
    kde-gtk-config = false;
  };

  # Enable the KDE Wallet to securely store secrets like Git credentials.
  security.pam.services.sddm.enableKwallet = true;

  # Install some common KDE apps system-wide
  environment.systemPackages = with pkgs; [
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.okular
  ];
}
