# modules/home-manager/programs/git.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;

    settings = {
      user.name = "Sander Mirck";
      user.email = "mail@sandermirck.nl.eu.org";
      core.editor = "nvim";
      pull.rebase = true;
    };
  };
}
