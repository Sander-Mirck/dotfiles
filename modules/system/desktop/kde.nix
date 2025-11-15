{ config, pkgs, ... }: {
  # KDE Plasma Home Manager integration
  xdg.enable = true;
  
  # KDE-specific applications and configuration
  home.packages = with pkgs; [
    # KDE applications
    kdePackages.konsole
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.gwenview
    kdePackages.okular
    kdePackages.ark
    
    # KDE utilities
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kcolorchooser
    
    # System integration
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
  ];

  # KDE configuration files
  xdg.configFile = {
    "kdeglobals".source = config.lib.file.mkOutOfStoreSymlink 
      (if (builtins.pathExists "${config.home.homeDirectory}/.config/kdeglobals")
       then "${config.home.homeDirectory}/.config/kdeglobals"
       else "${pkgs.plasma5Packages.plasma-workspace}/share/config/kdeglobals");
  };

  # Enable KDE Connect if desired
  # services.kdeconnect.enable = true;
  # services.kdeconnect.indicator = true;
}