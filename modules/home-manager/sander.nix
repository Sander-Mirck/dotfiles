{ config, pkgs, lib, ... }:

{
  home.username = "sander";
  home.homeDirectory = "/home/sander";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    # GNOME Extensions
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes

    # Security and productivity
    bitwarden-desktop
    gnupg
    keepassxc
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Sander Mirck";
      user.email = "sandermirck@gmail.com";
      credential.helper = "cache --timeout=300";
    };
  };

  programs.gpg = {
    enable = true;
    settings = {
      "personal-cipher-preferences" = "AES256,AES192,AES128";
      "personal-compress-preferences" = "ZLIB,BZIP2,Z0";
      "default-preference-list" = "SHA512 SHA384 SHA256 AES256 AES192 AES DSA3072 ECDH NIST P256 RSA3072";
    };
  };

  programs.password-store = {
    enable = true;
    settings.PASSWORD_STORE_DIR = "$HOME/.password-store";
  };

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        caffeine.extensionUuid
        clipboard-indicator.extensionUuid
        dash-to-dock.extensionUuid
        user-themes.extensionUuid
      ];
      disable-user-extensions = false;
    };

    "org/gnome/shell/extensions/user-themes" = {
      name = "Yaru-dark";
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dash-max-icon-size = 48;
      intellihide = true;
    };

    "org/gnome/desktop/screensaver" = {
      lock-enabled = true;
      lock-delay = 30;
    };

    "org/gnome/desktop/session" = {
      idle-delay = 300;
    };
  };

  home.sessionVariables = {
    EDITOR = "gnome-text-editor";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = lib.mkForce false;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraPython3Packages = ps: with ps; [ pynvim ];

    plugins = with pkgs.vimPlugins; [
      dracula-vim
    ];
  };

  xdg.configFile."nvim/init.lua".text = ''
    -- Set Dracula as the default theme
    vim.cmd('colorscheme dracula')

    -- Neovim UI settings
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.cursorline = true
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.autoindent = true
    vim.opt.smartindent = true
  '';
}
