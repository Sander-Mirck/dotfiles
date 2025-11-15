# lib/default.nix
{inputs, ...}: let
  # Helper function to generate a NixOS system configuration
  mkNixosSystem = {
    system ? "x86_64-linux",
    modules,
    username, # The primary username for this system
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      # Pass flake inputs to all modules.
      specialArgs = {inherit inputs;};

      modules = [
        # Import the host-specific modules.
        modules

        # Add Home Manager support.
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # Pass flake inputs to home-manager modules.
          home-manager.extraSpecialArgs = {inherit inputs;};
          # Import the user's home-manager configuration.
          home-manager.users.${username} = import ../modules/home-manager/${username}.nix;
        }

        # Apply custom overlays.
        ({config, pkgs, ...}: {
          nixpkgs.overlays = [
            (import ../overlays)
          ];
        })
      ];
    };
in {
  inherit mkNixosSystem;
}