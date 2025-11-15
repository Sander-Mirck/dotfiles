# modules/home-manager/sander.nix
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Programs
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/shell.nix

    # Services
    ./services/gpg-agent.nix
    ./services/ssh-agent.nix

    # Themes
    ./themes/gtk.nix

    # Desktop integration (assuming you might have one, e.g., kde.nix)
    # ./desktop/kde.nix
  ];

  # --- User Info ---
  home.username = "sander";
  home.homeDirectory = "/home/sander";

  # --- Home Manager ---
  programs.home-manager.enable = true;

  # --- State Version ---
  home.stateVersion = "25.05";

  # --- User-specific Packages ---
  home.packages = with pkgs; [
    # Development tools for Neovim LSP and other needs
    (python3.withPackages (ps:
      with ps; [
        pip
        setuptools
        pynvim
        virtualenv
      ]))
    lua-language-server
    # Note: nodejs, nil, and nixd are already in your system packages.

    # Utilities
    eza # Modern ls replacement
    fzf
    bat
    ripgrep
    fd
    jq
    yq
    htop
    btop
  ];

  # --- Environment Variables ---
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "konsole";
    PAGER = "bat";
    MANPAGER = "bat";
  };
}
