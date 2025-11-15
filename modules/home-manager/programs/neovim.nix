{ config, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    extraConfig = ''
      set number
      syntax on
    '';
  };
}
