# modules/home-manager/programs/ssh.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;

    # Match block for GitHub
    matchBlocks = {
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  # Ensure ssh-agent is running and keys are loaded
  services.ssh-agent.enable = true;

  # Optional: install key management tools
  home.packages = [
    pkgs.openssh
    pkgs.gnupg
  ];
}
