# modules/system/packages.nix
# Package management and system packages
{
  config,
  pkgs,
  lib,
  ...
}: let
  # --- Package Groups ---
  core-utils = with pkgs; [
    bat
    curl
    eza # Modern ls replacement
    fd
    git
    ripgrep
    tmux
    tree
    unzip
    wget
    wl-clipboard
    fzf
    jq
    yq
  ];

  development = with pkgs; [
    godot_4
    python3
    python3Packages.pip
    python3Packages.setuptools
    nodejs
    lua
  ];

  editors-ide = with pkgs; [
    emacs
    helix
    neovim
    obsidian
    vscodium
    # Nix Language Servers
    nil
    nixd
  ];

  communication = with pkgs; [
    cloudflared
    netbird-ui
    tailscale
    vesktop
  ];

  kde-desktop = with pkgs; [
    flatpak
    ocs-url
  ];

  gaming = with pkgs; [
    prismlauncher
  ];

  security-system = with pkgs; [
    gnupg
    pciutils
    usbutils
  ];

  system-monitoring = with pkgs; [
    btop
    htop
    hddtemp
    nix-output-monitor
    smartmontools
  ];

  terminals = with pkgs; [
    ghostty
    lazygit
  ];

  # --- Aggregate All Packages ---
  all-packages =
    core-utils
    ++ development
    ++ editors-ide
    ++ communication
    ++ kde-desktop
    ++ gaming
    ++ security-system
    ++ system-monitoring
    ++ terminals
    ++ [pkgs.firefox];
in {
  # --- System Packages ---
  environment.systemPackages = all-packages;

  # --- Program Configuration ---
  programs = {
    # Web Browser
    firefox.enable = true;

    # AppImage support
    appimage = {
      enable = true;
      binfmt = true;
    };

    # Default editor and terminal aliases
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    # Bash shell improvements
    bash.interactiveShellInit = ''
      # Better tab completion
      bind 'set show-all-if-ambiguous on'
      bind 'TAB:menu-complete'

      # Improved ls colors
      export LS_COLORS="di=1;36:ln=1;35:so=1;32:pi=1;33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
    '';

    # Enable useful network utilities
    mtr.enable = true;
    nmap.enable = true;
    wireshark.enable = true;
    command-not-found.enable = true;
  };

  # --- Environment Variables ---
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "konsole";
    PAGER = "bat";
    MANPAGER = "bat";
  };

  # --- Nix Configuration ---
  nix = {
    settings = {
      # Enable flakes and nix-command (already set in roles/common.nix but good to have here too)
      experimental-features = ["nix-command" "flakes"];

      # Auto optimize store
      auto-optimise-store = true;

      # Use all available cores for builds
      cores = 0;
      max-jobs = "auto";
    };

    # Enable automatic garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
