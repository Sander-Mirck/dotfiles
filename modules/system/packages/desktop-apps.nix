# modules/system/packages/desktop-apps.nix
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Communication
    cloudflared
    tailscale
    vesktop

    # KDE & Desktop
    flatpak
    ocs-url
    firefox
    kdenlive

    # Gaming
    prismlauncher
  ];
}
