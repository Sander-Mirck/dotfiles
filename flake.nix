# flake.nix
{
  description = "Sander's Professional NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # statix input has been removed.

    # deadnix is kept as an input for fast, reliable CI checks.
    deadnix = {
      url = "github:astro/deadnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs: let
    lib = import ./lib {inherit inputs;};
  in {
    # -- NIXOS CONFIGURATIONS --
    nixosConfigurations = {
      laptop = lib.mkNixosSystem {
        system = "x86_64-linux";
        modules = ./hosts/laptop;
      };

      server = lib.mkNixosSystem {
        system = "x86_64-linux";
        modules = ./hosts/server;
      };
    };

    # -- FORMATTER --
    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # -- LINTERS (for CI) --
    # statix package has been removed.
    packages.x86_64-linux.deadnix = inputs.deadnix.packages.x86_64-linux.default;

    # -- DEV SHELL --
    devShells.x86_64-linux.default = inputs.nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
        git
        nil 
        alejandra
        # statix package has been removed from the dev shell.
        inputs.deadnix.packages.x86_64-linux.default
      ];
    };
  };
}