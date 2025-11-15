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

    # The 'package' line that caused the error has been removed.
    # The default git package is now used.

    settings = {
      user.name = "Sander Mirck";
      user.email = "mail@sandermirck.nl.eu.org";
      core.editor = "nvim";
      pull.rebase = true;
    };

    # This section correctly configures Git to use the libsecret helper.
    extraConfig = {
      credential.helper = "libsecret";
    };
  };
}
