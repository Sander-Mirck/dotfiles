# /lib/flake-modules/hosts.nix
# This module defines all machine configurations and generates the
# corresponding nixosConfigurations and homeConfigurations.
{ inputs, ... }:
let
  # Define all your hosts here.
  hosts = {
    laptop = {
      system = "x86_64-linux";
      username = "sander";
      homeModule = ../../modules/home-manager/sander.nix;
      nixosModule = ../../hosts/laptop;
    };
  };

  # Import central options file.
  globalOptions = import ../../config/options.nix;

  # Helper function to generate a NixOS system configuration for a given host.
  mkNixosSystem =
    host:
    inputs.nixpkgs.lib.nixosSystem {
      inherit (host) system;

      # 1. We pass globalOptions here so System modules (like sudo.nix) can use it.
      specialArgs = {
        inherit inputs;
        username = host.username;
        inherit globalOptions; # RENAME: Passing it as 'globalOptions' safely.
      };

      modules = [
        host.nixosModule

        # Integrate Home Manager into the NixOS build.
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            extraSpecialArgs = {
              inherit inputs;
              username = host.username;
              # 2. We rename it here too, so Home Manager modules don't crash.
              inherit globalOptions;
            };

            users.${host.username} = host.homeModule;
          };
        }

        # Apply custom package overlays.
        { nixpkgs.overlays = [ (import ../../overlays) ]; }
      ];
    };

  # Helper function to generate a standalone Home Manager configuration.
  mkHomeConfiguration =
    host:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs {
        system = host.system;
        config.allowUnfree = true;
      };
      extraSpecialArgs = {
        inherit inputs;
        username = host.username;
        inherit globalOptions;
      };
      modules = [ host.homeModule ];
    };
in
{
  flake = {
    # Generate nixosConfigurations for each host defined above.
    nixosConfigurations = inputs.nixpkgs.lib.mapAttrs (name: host: mkNixosSystem host) hosts;

    # Generate homeConfigurations for each host.
    homeConfigurations = inputs.nixpkgs.lib.mapAttrs (name: host: mkHomeConfiguration host) hosts;
  };
}
