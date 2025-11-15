# roles/desktop.nix
#
# Configures a full desktop environment.
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Import common settings.
    ./common.nix

    # Import desktop-specific modules.
    ../modules/system/audio.nix
    ../modules/system/packages.nix
    ../modules/system/services.nix
    ../modules/system/shell-aliases.nix
    ../modules/system/desktop/kde.nix

    # Import package sets
    ../modules/system/packages/cli-tools.nix
    ../modules/system/packages/development.nix
    ../modules/system/packages/desktop-apps.nix
  ];
}