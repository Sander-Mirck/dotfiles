# Package management and system packages
{ config, pkgs, unstable, ... }:

{
  environment.systemPackages =
    # Packages from the stable channel
    [
      pkgs.bloomeetunes
    ]
    # '++' joins the two lists together
    ++
    # Packages from the unstable channel
    (with unstable; [
      git
      wget
      curl
      btop
      unzip
      neovim
      ghostty
      docker
      docker-compose
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
    ]);

  # Enable Firefox (from unstable too)
  programs.firefox.package = unstable.firefox;

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

