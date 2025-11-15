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

    # Theming and appearance
    ./themes/gtk.nix
  ];

  # Basic user and home directory settings
  home.username = "sander";
  home.homeDirectory = "/home/sander";

  # Enable home-manager
  programs.home-manager.enable = true;

  # Set the state version for home-manager
  home.stateVersion = "25.05";

  # Install packages directly into the user's profile
  home.packages = with pkgs; [
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
