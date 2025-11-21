# /modules/system/user-sander.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  # --- NEW: Tell Agenix where to find the decryption key ---
  # We point this to the key you generated manually with ssh-keygen.
  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  # Define the secret location
  age.secrets.user-password.file = ../../secrets/user-password.age;

  users.users.sander = {
    isNormalUser = true;
    description = "Sander Mirck";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
    ];

    # This sets your default login shell to Zsh.
    shell = pkgs.zsh;

    # 🔒 SECURE: Use the secret file defined above.
    hashedPasswordFile = config.age.secrets.user-password.path;

    openssh.authorizedKeys.keys = [
      # Add your SSH keys here if you ever want to SSH into this machine
      # "ssh-ed25519 AAAAC3Nza... your-comment"
    ];
  };
}
