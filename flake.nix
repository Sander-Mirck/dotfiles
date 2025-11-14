{
  description = "Sander's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./hosts/nixos

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.sander = import ./modules/home-manager/sander.nix;
          };
        }

        ({ config, pkgs, ... }: {
          nixpkgs.overlays = [ (import ./overlays) ];
        })
      ];
    };

    # Formatter for nix fmt
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;

    # Dev shell
    devShells.x86_64-linux.default =
      nixpkgs.legacyPackages.x86_64-linux.mkShell {
        packages = [
          nixpkgs.legacyPackages.x86_64-linux.git
          nixpkgs.legacyPackages.x86_64-linux.nil
          nixpkgs.legacyPackages.x86_64-linux.nixfmt
        ];
      };
  };
}
