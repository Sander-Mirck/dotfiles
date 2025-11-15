{
  description = "Sander's Professional NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix"; # for secrets management
  };

  outputs = { self, nixpkgs, home-manager, agenix, ... } @ inputs: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/laptop
          ./profiles/workstation.nix

          # Enable Home Manager as a NixOS module
          home-manager.nixosModules.home-manager

          # User configuration with Home Manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sander = import ./modules/home-manager/sander.nix;

            # Global Home Manager options
            home-manager.backupFileExtension = "backup";
          }

          # Overlays
          ({ config, pkgs, ... }: {
            nixpkgs.overlays = [ (import ./overlays) ];
          })
        ];
      };

      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/server
          ./profiles/server.nix
          home-manager.nixosModules.home-manager
          
          # Add basic Home Manager config for server if needed
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };

    # Formatter
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    # Dev shell
    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = with nixpkgs.legacyPackages.x86_64-linux; [
        git
        nil
        nixfmt
      ];
    };
  };
}