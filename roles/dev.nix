# roles/dev.nix
#
# Configures development and virtualization tools.
{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../modules/system/virtualisation.nix
  ];
}