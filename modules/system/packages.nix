# Package management and system packages
{
  config,
  pkgs,
  lib,
  ...
}: let
  # Categorized package groups
  core-utils = with pkgs; [
    git
    wget
    curl
    unzip
    tree
    bat
    fd
    ripgrep
    tmux
    wl-clipboard
  ];

  development = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.setuptools
    godot_4
  ];

  editors-ide = with pkgs; [
    neovim
    helix
    emacs
    vscodium
    obsidian
  ];

  system-monitoring = with pkgs; [
    btop
    smartmontools
    hddtemp
    nix-output-monitor
  ];

  communication = with pkgs; [
    vesktop
    tailscale
    netbird-ui
    cloudflared
  ];

  multimedia = with pkgs; [
    kdePackages.kdenlive
    scrcpy
    localsend
  ];

  gaming = with pkgs; [prismlauncher];

  security-system = with pkgs; [
    gnupg
    usbutils
    pciutils
  ];

  terminals = with pkgs; [
    ghostty
    lazygit
  ];

  all-packages =
    core-utils
    ++ development
    ++ editors-ide
    ++ system-monitoring
    ++ communication
    ++ multimedia
    ++ gaming
    ++ security-system
    ++ terminals
    ++ [pkgs.firefox];
in {
  environment.systemPackages = all-packages;

  programs.firefox.enable = true;

  # AppImage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Terminal experience
  programs.neovim = {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Environment variables
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
  };
}