# modules/home-manager/programs/shell.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;

    # Replaces deprecated initExtra
    initContent = ''
      autoload -Uz promptinit
      promptinit
      prompt agnoster
    '';

    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
    ];
  };

  programs.fzf.enable = true;
  programs.bat.enable = true;
}
