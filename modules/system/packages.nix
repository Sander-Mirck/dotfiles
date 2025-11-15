# Package management and system packages
{
  config,
  pkgs,
  lib,
  ...
}: let
  # ─── Package Groups ────────────────────────────────────────────────
  core-utils = with pkgs; [
    bat
    curl
    eza  # Modern ls replacement
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
    # qwen-code  # If broken/not present on your nixpkgs rev, comment this out.
  ];

  editors-ide = with pkgs; [
    emacs
    helix
    neovim
    obsidian
    vscodium
    # Add Nix LSP support
    nil
    nixd
  ];

  communication = with pkgs; [
    cloudflared
    netbird-ui
    tailscale
    vesktop
    # whatsapp-electron  # frequently broken; uncomment if you confirm it builds on your rev
  ];

  kde-desktop = with pkgs; [
    flatpak
    ocs-url
  ];

  gaming = with pkgs; [
    prismlauncher
  ];

  multimedia = with pkgs; [
    kdePackages.kdenlive
    localsend
    scrcpy
  ];

  security-system = with pkgs; [
    gnupg
    pciutils
    usbutils
  ];

  system-monitoring = with pkgs; [
    btop
    hddtemp
    nix-output-monitor
    smartmontools
    htop
  ];

  terminals = with pkgs; [
    ghostty
    lazygit
  ];

  # Optional packages that might be broken - conditionally include
  optional-packages = with pkgs; lib.optionals (lib.meta.availableOn stdenv.hostPlatform pkgs) [
    # Add any optional packages here
  ];

  # ─── Aggregate All Packages ────────────────────────────────────────
  all-packages =
    core-utils
    ++ development
    ++ editors-ide
    ++ communication
    ++ kde-desktop
    ++ gaming
    ++ multimedia
    ++ security-system
    ++ system-monitoring
    ++ terminals
    ++ optional-packages
    ++ [pkgs.firefox];
in {
  # ─── System Packages ───────────────────────────────────────────────
  environment.systemPackages = all-packages;

  # ─── Programs ──────────────────────────────────────────────────────
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # Enhanced bash configuration
  programs.bash = {
    interactiveShellInit = ''
      # Better tab completion
      bind 'set show-all-if-ambiguous on'
      bind 'TAB:menu-complete'
      
      # Improved ls colors
      export LS_COLORS="di=1;36:ln=1;35:so=1;32:pi=1;33:ex=1;31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
    '';
  };

  programs.neovim = {
    defaultEditor = false;
    viAlias = true;
    vimAlias = true;
  };

  # Enable useful system utilities
  programs = {
    mtr.enable = true;
    nmap.enable = true;
    wireshark.enable = true;
    command-not-found.enable = true;
  };

  # ─── Environment Variables ─────────────────────────────────────────
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "konsole";
    PAGER = "bat";
    MANPAGER = "bat";
  };

  # ─── Nix Configuration ─────────────────────────────────────────────
  nix = {
    settings = {
      # Enable flakes and nix-command
      experimental-features = ["nix-command" "flakes"];
      
      # Auto optimize store
      auto-optimise-store = true;
      
      # Build cores
      cores = 0; # Use all available cores
      max-jobs = "auto";
    };
    
    # Enable garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}