# /flake.nix
{
  description = "Sander's NixOS Configuration";

  inputs = {
    # Use nixos-unstable for the latest packages and features.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager for declarative user-level package management.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # deadnix for identifying and removing unused Nix code.
    deadnix = {
      url = "github:astro/deadnix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # flake-utils for boilerplate reduction across systems.
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    ...
  } @ inputs: let
    # Import custom library functions.
    lib = import ./lib {inherit inputs;};
  in
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      # Default formatter for `nix fmt`.
      formatter = pkgs.alejandra;

      # Linter to detect dead code.
      packages.deadnix = inputs.deadnix.packages.${system}.default;

      # Development shell with essential tools.
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
      # NixOS system configurations, defined per host.
      nixosConfigurations = {
        laptop = lib.mkNixosSystem {
          system = "x86_64-linux";
          modules = ./hosts/laptop;
          username = "sander";
        };
      };

      # Standalone home-manager configurations.
      homeConfigurations = {
        sander = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {inherit inputs;};
          modules = [./modules/home-manager/sander.nix];
        };
      };
    };
}
