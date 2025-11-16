# modules/system/desktop/kde.nix
{
  config,
  pkgs,
  lib,
  ...
}: let
  # This derivation copies your custom wallpaper into the Nix store
  # so that SDDM can access it with a stable, absolute path.
  sddm-wallpaper = pkgs.stdenv.mkDerivation {
    name = "sddm-wallpaper";
    src = ../../../assets/wallpaper.png; # Path relative to this .nix file
    dontUnpack = true;
    installPhase = ''
      mkdir -p $out/share/wallpapers
      cp $src $out/share/wallpapers/wallpaper.png
    '';
  };

  # This creates the theme.conf.user file that tells the Breeze SDDM theme
  # where to find the background wallpaper.
  sddm-theme-config = pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
    [General]
    background=${sddm-wallpaper}/share/wallpapers/wallpaper.png
  '';
in {
  # Enable the X server
  services.xserver.enable = true;

  # Configure the SDDM display manager
  services.displayManager.sddm = {
    enable = true;
    # We still use the 'breeze' theme, but we override its background.
    theme = "breeze";
  };

  # Enable the KDE Plasma 6 desktop environment
  services.desktopManager.plasma6.enable = true;

  # Enable the KDE Wallet to securely store secrets like Git credentials.
  security.pam.services.sddm.enableKwallet = true;

  # Install the theme configuration and some common KDE apps system-wide
  environment.systemPackages = with pkgs; [
    sddm-theme-config # This injects our theme.conf.user file
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.okular
  ];
}
