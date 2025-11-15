# modules/home-manager/sander.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/shell.nix

    ./services/gpg-agent.nix
    ./services/ssh-agent.nix

    ./themes/gtk.nix
    ./themes/hyprland.nix
  ];

  home.username = "sander";
  home.homeDirectory = "/home/sander";

  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
