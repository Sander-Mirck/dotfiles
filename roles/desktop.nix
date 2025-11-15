# /roles/desktop.nix
# This role configures a complete graphical desktop environment.
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Include the base system configuration.
    ./common.nix

    # Import modules specific to a desktop setup.
    ../modules/system/audio.nix
    ../modules/system/packages.nix
    ../modules/system/services.nix
    ../modules/system/shell-aliases.nix
    ../modules/system/desktop/kde.nix

    # Import package sets for a desktop environment.
    ../modules/system/packages/cli-tools.nix
    ../modules/system/packages/development.nix
    ../modules/system/packages/desktop-apps.nix
  ];
}
