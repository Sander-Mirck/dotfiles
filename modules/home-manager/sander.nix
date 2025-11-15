# /modules/home-manager/sander.nix
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    # User-specific program configurations
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/shell.nix

    # User-level services
    ./services/gpg-agent.nix
    ./services/ssh-agent.nix

    # The old ./themes/gtk.nix import is now gone
  ];

  # Basic user and home directory settings
  home.username = "sander";
  home.homeDirectory = "/home/sander";

  # Enable home-manager
  programs.home-manager.enable = true;
  home.stateVersion = "25.05";

  # Add this entire block to control GTK themes via KDE's database
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "Adwaita-dark";
      icon-theme = "Papirus";
    };
  };

  # Install packages directly into the user's profile
  home.packages = with pkgs; [
    # Packages for GTK theming (needed by KDE)
    gnome-themes-extra # provides Adwaita-dark
    papirus-icon-theme # provides Papirus

    # For Git credential helper
    libsecret

    # Python environment
    (python3.withPackages (
      ps: with ps; [
        pip
        setuptools
        pynvim
        virtualenv
      ]
    ))

    # Development tools
    lua-language-server

    # CLI tools and enhancements
    eza
    fzf
    bat
    ripgrep
    fd
    jq
    yq
    htop
    btop
  ];

  # Set user-specific environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "konsole";
    PAGER = "bat";
    MANPAGER = "bat";
  };
}
