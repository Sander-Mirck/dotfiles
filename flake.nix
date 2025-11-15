{
  description = "Sander's Professional NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
          agenix.nixosModules.default

          # Enable Home Manager as a NixOS module
          home-manager.nixosModules.home-manager

          # User configuration with Home Manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.sander = import ./modules/home-manager/sander.nix;

            # Pass inputs to Home Manager
            home-manager.extraSpecialArgs = {inherit inputs;};

            # Global Home Manager options
            home-manager.backupFileExtension = "backup";
          }

          # Overlays
          ({
            config,
            pkgs,
            ...
          }: {
            nixpkgs.overlays = [(import ./overlays)];
          })
        ];
      };

      # Add server configuration back
      server = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./profiles/server.nix
        ];
      };
    };

    # Formatter for all systems
    formatter = {
      x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
      aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;
    };

    # Dev shell with enhanced tooling
    devShells = {
      x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
        packages = with nixpkgs.legacyPackages.x86_64-linux; [
          git
          nil
          nixfmt
          statix
          deadnix
          nixd
        ];

        shellHook = ''
          echo "🔧 NixOS Development Shell"
          echo "Available commands:"
          echo "  nix fmt    - Format Nix files"
          echo "  nix flake check - Check flake"
          echo "  statix check    - Lint Nix code"
          echo "  deadnix .       - Find unused code"
        '';
      };
    };

    # Templates for new hosts
    templates = {
      host = {
        path = ./templates/host.nix;
        description = "Basic host template";
      };
      workstation = {
        path = ./templates/workstation.nix;
        description = "Workstation profile template";
      };
    };
  };
}