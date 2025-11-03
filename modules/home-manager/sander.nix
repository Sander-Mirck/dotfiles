# /etc/nixos/modules/home-manager/sander.nix
{ pkgs, ... }:

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
  ];

  # Enable and configure git
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Sander Mirck";
        email = "sandermirck@gmail.com";
      };
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
  };

  # Let Home Manager manage its own session variables
  home.sessionVariables = {
    EDITOR = "gnome-text-editor";
  };
}