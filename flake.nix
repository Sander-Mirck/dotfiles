{
  description = "Sander's Professional NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    ...
  } @ inputs: let
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

    # -- DEV SHELL --
    devShells.x86_64-linux.default = inputs.nixpkgs.legacyPackages.x86_64-linux.mkShell {
      packages = with inputs.nixpkgs.legacyPackages.x86_64-linux; [
        git
        nil # Nix Language Server
        alejandra # The formatter
      ];
    };
  };
}
