# modules/system/packages/development.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # General
    godot_4
    python3
    python3Packages.pip
    python3Packages.setuptools
    nodejs
    lua

    # Editors & IDEs
    emacs
    helix
    neovim
    obsidian
    vscodium
    zed-editor

    # Nix Language Servers
    nil
    nixd
  ];
}
