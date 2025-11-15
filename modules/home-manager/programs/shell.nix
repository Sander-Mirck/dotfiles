{ config, pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.theme = "agnoster";
    ohMyZsh.plugins = [ "git" "sudo" "history" ];
  };

  programs.fzf.enable = true;
  programs.bat.enable = true;
}
