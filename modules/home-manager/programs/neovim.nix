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

    # Do not use wrapper provider flags on this nixpkgs; install providers explicitly.
    # withNodeJs = true;
    # withPython3 = true;

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

  # IMPORTANT: install only one Python derivation to avoid bin collisions.
  # Remove any other `python3` or `python3.withPackages` entries from other HM files.
  home.packages = with pkgs; [
    nodejs
    (python3.withPackages (ps: [ps.pip ps.setuptools ps.pynvim]))
    lua
    lua-language-server
  ];

  home.sessionVariables.EDITOR = "nvim";
}
