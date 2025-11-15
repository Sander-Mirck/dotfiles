# /etc/nixos/overlays/default.nix
#
# This file is for Nixpkgs overlays. Overlays are used to
# customize packages, such as applying patches or changing build options.
self: super: {
  # Example: Add a custom command-line argument to google-chrome
  # google-chrome = super.google-chrome.override {
  #   commandLineArgs = "--force-dark-mode";
  # };

  # Example: Use a specific version of a package
  # my-neovim = super.neovim.overrideAttrs (old: {
  #   version = "0.9.5";
  #   src = super.fetchFromGitHub {
  #     owner = "neovim";
  #     repo = "neovim";
  #     rev = "v0.9.5";
  #     sha256 = "sha256-iLD/8vHXRVzC80iS22dUg8PlDsYVLs67vB+aOqs3lDI=";
  #   };
  # });
}
