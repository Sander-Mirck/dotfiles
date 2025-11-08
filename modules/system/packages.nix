# Package management and system packages
{ config, pkgs, ... }:

let
  # Categorized package groups for better organization
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
    qwen-code
  ];

  editors-ide = with pkgs; [
    neovim
    evil-helix
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
    whatsapp-electron
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
    # lutris
    prismlauncher
  ];

  gnome-desktop = with pkgs; [
    gnome-tweaks
    flatpak
    ocs-url
  ];

  security-system = with pkgs; [
    gnupg
    haveged
    usbutils
    pciutils
  ];

  terminals = with pkgs; [
    ghostty
    lazygit
  ];

  # Combine all package groups
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
    [ pkgs.firefox ];  # Firefox as standalone since it's also configured separately

in {
  environment.systemPackages = all-packages;

  # Browser configuration
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
  };

  # Shell aliases for Nix commands
  environment.shellAliases = {
    # NixOS rebuild commands
    nrs = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    nrsu = "sudo nixos-rebuild switch --upgrade --flake /etc/nixos#nixos";
    nrb = "sudo nixos-rebuild boot --flake /etc/nixos#nixos";
    nrt = "sudo nixos-rebuild test --flake /etc/nixos#nixos";
    
    # Nix garbage collection
    nrgc = "sudo nix-collect-garbage -d";
    nix-update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos --upgrade";
    
    # Utility aliases (optional additions)
    ll = "ls -la";
    update = "nix-update";
  };

  # AppImage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  
  # Security settings
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  # System entropy improvement
  services.haveged.enable = true;

  # Additional program configurations (optional enhancements)
  programs = {
    # Better terminal experience
    bash.interactiveShellInit = ''
      # Enable better tab completion
      bind 'set show-all-if-ambiguous on'
      bind 'TAB:menu-complete'
    '';

    # Neovim as default editor if desired
    neovim = {
      defaultEditor = false;  # Set to true if you want nvim as default
      viAlias = true;
      vimAlias = true;
    };
  };

  # Environment variables
  environment.variables = {
    EDITOR = "nvim";  # Or "gnome-text-editor" if you prefer
    VISUAL = "nvim";
    BROWSER = "firefox";
  };
}