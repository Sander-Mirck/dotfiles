# /modules/system/user-sander.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  users.users.sander = {
    isNormalUser = true;
    description = "Sander Mirck";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];

    # This is the new, crucial line that fixes everything.
    # It sets your default login shell to Zsh.
    shell = pkgs.zsh;

    # 🔒 SECURE: Use hashed password
    hashedPassword = "$6$VUiEylEBRqJYd/7.$m6sXKpXOyEOYa4guwyO4BLNIqKYhNqb.9UR14zLaIyC4zv1x/86nQputX7RZ8.aRs.7QYwlFKZ7xmSgNlp1FO/";

    openssh.authorizedKeys.keys = [
      # Add your SSH keys here
      # "ssh-ed25519 AAAAC3Nza... your-comment"
    ];
  };
}
