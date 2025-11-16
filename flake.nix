{
  description = "Sander's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    deadnix = {
      url = "github:astro/deadnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      # We specify which systems we want our configurations to build for.
      systems = ["x86_64-linux"];

      # Import modularized parts of our flake.
      imports = [
        ./lib/flake-modules/dev.nix
        ./lib/flake-modules/hosts.nix
      ];
    };
}
