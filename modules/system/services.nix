# System services
{ pkgs, lib, ... }:

{
  # X11 + GNOME
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb.layout = "us";

  # Printing
  services.printing.enable = true;

  # Enable Docker service
  virtualisation.docker.enable = true;

  # Enable Flatpak system-wide
  services.flatpak.enable = true;

  # Ensure Flatpak apps' .desktop files are visible in GNOME
  environment.sessionVariables.XDG_DATA_DIRS = lib.mkForce
    "/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";

  # Automatically add Flathub remote for all users
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
