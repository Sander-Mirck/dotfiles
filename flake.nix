# flake.nix
{
  description = "Sander's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deadnix = {
      url = "github:astro/deadnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    ...
  } @ inputs: let
    # Define lib at the top level so it's accessible everywhere
    lib = import ./lib {inherit inputs;};
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      # -- FORMATTER --
      formatter = pkgs.alejandra;

      # -- LINTER --
      packages.deadnix = inputs.deadnix.packages.${system}.default;

      # -- DEV SHELL --
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.git
          pkgs.nil
          pkgs.alejandra
          self.packages.${system}.deadnix
        ];
      };
    })
    // {
      # -- NIXOS CONFIGURATIONS --
      nixosConfigurations = {
        laptop = lib.mkNixosSystem {
          system = "x86_64-linux";
          modules = ./hosts/laptop;
          username = "sander";
        };
      };

      # -- HOME MANAGER CONFIGURATIONS --
      homeConfigurations = {
        sander = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {inherit inputs;};
          modules = [./modules/home-manager/sander.nix];
        };
      };
    };
}