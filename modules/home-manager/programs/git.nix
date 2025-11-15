{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Sander Mirck";
    userEmail = "mail@sandermirck.nl.eu.org";
    extraConfig = {
      core.editor = "nvim";
      pull.rebase = true;
    };
  };
}
