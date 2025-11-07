# /etc/nixos/modules/home-manager/sander.nix
{ config, pkgs, ... }:

{
  # Set your basic user information
  home.username = "sander";
  home.homeDirectory = "/home/sander";

  # This is the state version for Home Manager. It's a good idea to set it.
  home.stateVersion = "25.05";

  # Install user-specific packages, including your GNOME extensions
  home.packages = with pkgs; [
    # Add your GNOME extensions here
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
    
    # Security and system tools
    bitwarden-desktop
    gnupg
    keepassxc
  ];

  # Enable and configure git
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sander Mirck";
        email = "sandermirck@gmail.com";
      };
      # Security: Don't store credentials in plain text by default
      credential.helper = "cache --timeout=300";  # 5 minutes
    };
  };

  # Enable and configure GPG
  programs.gpg = {
    enable = true;
    settings = {
      # Security improvements
      "personal-cipher-preferences" = "AES256,AES192,AES128";
      "personal-compress-preferences" = "ZLIB,BZIP2,Z0";
      "default-preference-list" = "SHA512 SHA384 SHA256 AES256 AES192 AES DSA3072 ECDH NIST P256 RSA3072";
    };
  };

  # Enable password manager
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.password-store";
    };
  };

  # GNOME and dconf settings for declarative management
  dconf.settings = {
    "org/gnome/shell" = {
      # This is the crucial part: list the extensions to enable by their UUID
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        caffeine.extensionUuid
        clipboard-indicator.extensionUuid
        dash-to-dock.extensionUuid
        user-themes.extensionUuid
      ];
      # Also ensure user extensions are not globally disabled
      disable-user-extensions = false;
    };

    # This setting is needed for the 'user-themes' extension to work
    "org/gnome/shell/extensions/user-themes" = {
      name = "Yaru-dark"; # You can change "Yaru-dark" to your preferred theme name
    };
    
    # Optional: Example of configuring an extension directly (Dash to Dock)
    # You can find these settings using the `dconf-editor` tool.
    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      dash-max-icon-size = 48;
      intellihide = true;
    };
    
    # Security: Lock screen after inactivity
    "org/gnome/desktop/screensaver" = {
      lock-enabled = true;
      lock-delay = 30;  # Lock 30 seconds after screensaver starts
    };
    
    "org/gnome/desktop/session" = {
      idle-delay = 300;  # Activate screensaver after 5 minutes
    };
  };

  # Let Home Manager manage its own session variables
  home.sessionVariables = {
    EDITOR = "gnome-text-editor";
  };
}