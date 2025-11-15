# modules/home-manager/programs/neovim.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;

    extraConfig = ''
      set number
      set relativenumber
      set cursorline
      syntax on

      set tabstop=4
      set shiftwidth=4
      set expandtab
      set smartindent
    '';

    plugins = with pkgs.vimPlugins; [
      dracula-vim
      nvim-lspconfig
      nvim-treesitter
      telescope-nvim
      plenary-nvim
    ];
  };

  # The home.packages section has been removed from this file
  # to prevent python environment collisions. The necessary packages
  # are handled in modules/home-manager/sander.nix

  home.sessionVariables.EDITOR = "nvim";
}
