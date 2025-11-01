# Package management and system packages
{ config, pkgs, ... }:

{
  environment.systemPackages =
    # All packages are from the unstable channel
    (with pkgs; [
      git
      wget
      curl
      btop
      unzip
      neovim
      ghostty
      lazygit
      ripgrep
      fd
      tree
      vscodium
      firefox
      flatpak
      ocs-url
      gnome-tweaks
      vesktop
      kdePackages.kdenlive
      bat
      scrcpy
      localsend
      tailscale
      tmux
      godot_4
      cloudflared
      whatsapp-electron
      nix-output-monitor
      obsidian
      lutris
      netbird-ui
      prismlauncher
    ]);

  # Enable Firefox (from unstable too)
  programs.firefox.package = pkgs.firefox;

  # Shell aliases for Nix commands
  environment.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    nrsu = "sudo nixos-rebuild switch --upgrade --flake /etc/nixos#nixos";
    nrb = "sudo nixos-rebuild boot --flake /etc/nixos#nixos";
    nrt = "sudo nixos-rebuild test --flake /etc/nixos#nixos";
    nrgc = "sudo nix-collect-garbage -d";
    nix-update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos --upgrade";
  };

  # Appimage support
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}

