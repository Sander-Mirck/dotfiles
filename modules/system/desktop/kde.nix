<<<<<<< HEAD
{ config, pkgs, ... }: {
  # KDE Plasma Home Manager integration
  xdg.enable = true;
  
=======
{
  config,
  pkgs,
  ...
}: {
  # KDE Plasma Home Manager integration
  xdg.enable = true;

>>>>>>> b74654d (feat: resolve flake inconsistencies and modernize configuration)
  # KDE-specific applications and configuration
  home.packages = with pkgs; [
    # KDE applications
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.gwenview
    kdePackages.okular
    kdePackages.ark
<<<<<<< HEAD
    
=======

>>>>>>> b74654d (feat: resolve flake inconsistencies and modernize configuration)
    # KDE utilities
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kcolorchooser
<<<<<<< HEAD
    
=======

>>>>>>> b74654d (feat: resolve flake inconsistencies and modernize configuration)
    # System integration
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
  ];

  # KDE configuration files
  xdg.configFile = {
<<<<<<< HEAD
    "kdeglobals".source = config.lib.file.mkOutOfStoreSymlink 
      (if (builtins.pathExists "${config.home.homeDirectory}/.config/kdeglobals")
       then "${config.home.homeDirectory}/.config/kdeglobals"
       else "${pkgs.plasma5Packages.plasma-workspace}/share/config/kdeglobals");
=======
    "kdeglobals".source =
      config.lib.file.mkOutOfStoreSymlink
      (
        if (builtins.pathExists "${config.home.homeDirectory}/.config/kdeglobals")
        then "${config.home.homeDirectory}/.config/kdeglobals"
        else "${pkgs.plasma5Packages.plasma-workspace}/share/config/kdeglobals"
      );
>>>>>>> b74654d (feat: resolve flake inconsistencies and modernize configuration)
  };

  # Enable KDE Connect if desired
  # services.kdeconnect.enable = true;
  # services.kdeconnect.indicator = true;
<<<<<<< HEAD
}
=======
}
>>>>>>> b74654d (feat: resolve flake inconsistencies and modernize configuration)
