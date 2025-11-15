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
    # Use the default Plasma theme, which supports custom backgrounds
    theme = "breeze";
    settings = {
      Theme = {
        # Set your custom wallpaper path here
        background = "/home/sander/Pictures/wallpapers/nix-wallpaper-binary-black_8k.png";
      };
    };
  };

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
