# /overlays/default.nix
# This file defines custom modifications to the nixpkgs package set.
# It allows you to override existing packages or add new ones.
self: super: {
  # Example: Override google-chrome to launch in dark mode.
  # google-chrome = super.google-chrome.override {
  #   commandLineArgs = "--force-dark-mode";
  # };

  # Example: Pin Neovim to a specific version.
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
