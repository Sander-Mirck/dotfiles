{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Programs
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/shell.nix
    
    # Services
    ./services/gpg-agent.nix
    ./services/ssh-agent.nix
    
    # Themes
    ./themes/gtk.nix
<<<<<<< HEAD
    
=======

>>>>>>> b74654d (feat: resolve flake inconsistencies and modernize configuration)
    # Desktop integration
    ./desktop/kde.nix
  ];

  # ─── User Info ───────────────────────────────────────────────
  home.username = "sander";
  home.homeDirectory = "/home/sander";

  # ─── Home Manager ────────────────────────────────────────────
  programs.home-manager.enable = true;

  # ─── State Version ───────────────────────────────────────────
  home.stateVersion = "25.05";

  # ─── Enhanced Home Configuration ─────────────────────────────
  home.packages = with pkgs; [
    # Development tools
    nodejs
<<<<<<< HEAD
    (python3.withPackages (ps: with ps; [
      pip
      setuptools
      pynvim
      virtualenv
    ]))
    lua
    lua-language-server
    nil  # Nix LSP
    nixd # Nix LSP server

    # Utilities
    eza  # Modern ls replacement
=======
    (python3.withPackages (ps:
      with ps; [
        pip
        setuptools
        pynvim
        virtualenv
      ]))
    lua
    lua-language-server
    nil # Nix LSP
    nixd # Nix LSP server

    # Utilities
    eza # Modern ls replacement
>>>>>>> b74654d (feat: resolve flake inconsistencies and modernize configuration)
    fzf
    bat
    ripgrep
    fd
    jq
    yq
    htop
    btop
  ];

  # Better environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    BROWSER = "firefox";
    TERMINAL = "konsole";
    PAGER = "bat";
    MANPAGER = "bat";
  };

  # Enable useful services
  services = {
    # SSH agent with better configuration
    ssh-agent = {
      enable = true;
    };

    # GPG agent with SSH support
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
      pinentryFlavor = "qt"; # Use Qt pinentry for KDE
    };
  };
<<<<<<< HEAD
}
=======
}
>>>>>>> b74654d (feat: resolve flake inconsistencies and modernize configuration)
