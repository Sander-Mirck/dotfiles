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

    # Set a temporary password; change immediately after first login or
    # replace with hashedPassword from /etc/shadow using mkpasswd.
    initialPassword = "temp";

    openssh.authorizedKeys.keys = [
      # Add your SSH public keys here
    ];
  };
}
