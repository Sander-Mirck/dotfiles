# modules/system/user-sander.nix
# User configuration for sander
{
  config,
  pkgs,
  lib,
  ...
}: {
  users.users.sander = {
    isNormalUser = true;
    description = "Sander Mirck";
    extraGroups = ["networkmanager" "wheel" "docker" "libvirtd"];

    # Set a password.
    # For better security, you can generate a hash using `mkpasswd -m sha-512`
    # and set `hashedPassword` instead of `initialPassword`.
    initialPassword = "temp"; # Change this to a secure password

    openssh.authorizedKeys.keys = [
      # Add your SSH public keys here
    ];
  };
}