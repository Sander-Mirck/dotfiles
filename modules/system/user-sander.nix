# /modules/system/user-sander.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  # Defines the primary user account for the system.
  users.users.sander = {
    isNormalUser = true;
    description = "Sander Mirck";
    extraGroups = ["networkmanager" "wheel" "docker" "libvirtd"];

    # Set an initial password. For better security, replace this with `hashedPassword`.
    initialPassword = "temp";

    openssh.authorizedKeys.keys = [
      # Add public SSH keys here for remote access.
    ];
  };
}
