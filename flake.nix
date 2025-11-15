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

  outputs = {
    self,
    nixpkgs,
    home-manager,
    agenix,
    ...
  } @ inputs: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/laptop
          ./profiles/workstation.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.sander = import ./modules/home-manager/sander.nix;
          }
          ({
            config,
            pkgs,
            ...
          }: {
            nixpkgs.overlays = [(import ./overlays)];
          })
        ];
      };

      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/server
          ./profiles/server.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };

    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = with nixpkgs.legacyPackages.x86_64-linux; [
        git
        nil
        nixfmt
      ];
    };
  };
}
