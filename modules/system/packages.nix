# Package management and system packages
{ config, pkgs, lib, ... }:

let
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
    # qwen-code  # If broken/not present on your nixpkgs rev, comment this out.
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
    # whatsapp-electron  # frequently broken; uncomment if you confirm it builds on your rev
    tailscale
    netbird-ui
    cloudflared
  ];

  multimedia = with pkgs; [
    kdePackages.kdenlive
    scrcpy
    localsend
  ];

  gaming = with pkgs; [
    prismlauncher
  ];

  gnome-desktop = with pkgs; [
    gnome-tweaks
    flatpak
    ocs-url
  ];

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
    core-utils ++
    development ++
    editors-ide ++
    system-monitoring ++
    communication ++
    multimedia ++
    gaming ++
    gnome-desktop ++
    security-system ++
    terminals ++
    [ pkgs.firefox ];
in
{
  environment.systemPackages = all-packages;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  # AppImage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Terminal experience
  programs = {
    bash.interactiveShellInit = ''
      # Better tab completion
      bind 'set show-all-if-ambiguous on'
      bind 'TAB:menu-complete'
    '';

    neovim = {
      defaultEditor = false;
      viAlias = true;
      vimAlias = true;
    };
  };

  # Environment variables
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
  };
}
