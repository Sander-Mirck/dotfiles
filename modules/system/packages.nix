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
    fd
    git
    ripgrep
    tmux
    tree
    unzip
    wget
    wl-clipboard
  ];

  development = with pkgs; [
    godot_4
    python3
    python3Packages.pip
    python3Packages.setuptools
    # qwen-code  # If broken/not present on your nixpkgs rev, comment this out.
  ];

  editors-ide = with pkgs; [
    emacs
    helix
    neovim
    obsidian
    vscodium
  ];

  communication = with pkgs; [
    cloudflared
    netbird-ui
    tailscale
    vesktop
    # whatsapp-electron  # frequently broken; uncomment if you confirm it builds on your rev
  ];

  gnome-desktop = with pkgs; [
    flatpak
    gnome-tweaks
    ocs-url
  ];

  gaming = with pkgs; [
    prismlauncher
  ];

  multimedia = with pkgs; [
    kdePackages.kdenlive
    localsend
    scrcpy
    stremio
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
  ];

  terminals = with pkgs; [
    ghostty
    lazygit
  ];

  # ─── Aggregate All Packages ────────────────────────────────────────
  all-packages =
    core-utils
    ++ development
    ++ editors-ide
    ++ communication
    ++ gnome-desktop
    ++ gaming
    ++ multimedia
    ++ security-system
    ++ system-monitoring
    ++ terminals
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

  # ─── Environment Variables ─────────────────────────────────────────
  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
  };
}
