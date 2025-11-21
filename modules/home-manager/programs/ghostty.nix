# /modules/home-manager/programs/ghostty.nix
{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    # We are using the package from nixpkgs
    package = pkgs.ghostty;

    # Set the font to the Nerd Font we installed earlier.
    # The font size can be adjusted to your liking.
    settings = {
      font-family = "FiraCode Nerd Font";
      font-size = 12;
    };
  };
}
