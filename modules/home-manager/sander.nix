# modules/home-manager/sander.nix
{ config, pkgs, lib, ... }:

{
  imports = [
    # Programs
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/shell.nix

    # Services
    ./services/gpg-agent.nix
    ./services/ssh-agent.nix

    # Themes
    ./themes/gtk.nix
    ./themes/hyprland.nix
  ];

  # ─── User Info ───────────────────────────────────────────────
  home.username = "sander";
  home.homeDirectory = "/home/sander";

  # ─── Home Manager ────────────────────────────────────────────
  programs.home-manager.enable = true;

  # Handle conflicting files safely
  home-manager.backupFileExtension = "backup";
  # Alternatively, force overwrite specific files:
  xdg.configFile."gtkrc-2.0".force = true;

  # ─── State Version ───────────────────────────────────────────
  home.stateVersion = "25.05";
}
