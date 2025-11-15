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

<<<<<<< HEAD
  # Handle conflicting files safely
  home-manager.backupFileExtension = "backup";
  # Alternatively, force overwrite specific files:
  xdg.configFile."gtkrc-2.0".force = true;
=======
  # Manage GTK2 config file explicitly (provide content + allow overwrite)
  home.file.".gtkrc-2.0" = {
    text = ''
      gtk-theme-name="Adwaita-dark"
      gtk-icon-theme-name="Papirus"
    '';
    force = true;
  };
>>>>>>> 987ea52 (ci(home-manager): fix activation issue, update workflows, remove stremio)

  # ─── State Version ───────────────────────────────────────────
  home.stateVersion = "25.05";
}
