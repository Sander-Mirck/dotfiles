# /lib/default.nix
{inputs, ...}: let
  # A helper function to construct a NixOS system configuration.
  # It standardizes the inclusion of home-manager, overlays, and passes flake inputs.
  mkNixosSystem = {
    system ? "x86_64-linux",
    modules,
    username,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      # Pass flake inputs to all modules for easy access.
      specialArgs = {inherit inputs;};

      modules = [
        # Import the host-specific configuration.
        modules

        # Integrate home-manager into the NixOS build.
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.${username} = import ../modules/home-manager/${username}.nix;
        }

        # Apply custom package overlays.
        ({
          config,
          pkgs,
          ...
        }: {
          nixpkgs.overlays = [
            (import ../overlays)
          ];
        })
      ];
    };
in {
  # Expose the helper function to the rest of the configuration.
  inherit mkNixosSystem;
}
