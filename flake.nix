# flake.nix
{
  description = "Sander's Professional NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add statix as a flake input
    statix = {
      url = "github:nerdypepper/statix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add deadnix as a flake input
    deadnix = {
      url = "github:astro/deadnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, ...} @ inputs: let
    # Import the library helper function.
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
    # Expose statix and deadnix for easy access
    packages.x86_64-linux.statix = inputs.statix.packages.x86_64-linux.default;
    packages.x86_64-linux.deadnix = inputs.deadnix.packages.x86_64-linux.default;

    # -- DEV SHELL --
    devShells.x86_64-linux.default = inputs.nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
        git
        nil # Nix Language Server
        alejandra # The formatter
        inputs.statix.packages.x86_64-linux.default # Add statix to the dev shell
        inputs.deadnix.packages.x86_64-linux.default # Add deadnix to the dev shell
      ];
    };
  };
}
