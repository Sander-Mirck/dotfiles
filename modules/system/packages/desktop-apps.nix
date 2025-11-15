# modules/system/packages/desktop-apps.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Communication
    cloudflared
    netbird-ui
    tailscale
    vesktop

    # KDE & Desktop
    flatpak
    ocs-url
    firefox

    # Gaming
    prismlauncher
  ];
}