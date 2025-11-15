# modules/home-manager/programs/git.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.git = {
    enable = true;

    # No 'package' override is needed here.

    # All settings are now combined in this single block.
    settings = {
      user.name = "Sander Mirck";
      user.email = "mail@sandermirck.nl.eu.org";
      core.editor = "nvim";
      pull.rebase = true;
      # The line from extraConfig has been moved here.
      credential.helper = "libsecret";
    };

    # The old 'extraConfig' block has been removed.
  };
}
