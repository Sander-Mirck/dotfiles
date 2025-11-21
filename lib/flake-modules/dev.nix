# /lib/flake-modules/dev.nix
# This flake module defines developer-centric outputs like formatters and shells.
{ inputs, ... }:
{
  perSystem =
    {
      config,
      self',
      pkgs,
      ...
    }:
    {
      # Default formatter for `nix fmt`.
      formatter = pkgs.alejandra;

      # Linter to detect dead code.
      # We must specify the system architecture to get the correct package.
      packages.deadnix = inputs.deadnix.packages.${pkgs.system}.default;

      # Development shell with essential tools.
      devShells.default = pkgs.mkShell {
        packages = [
          pkgs.git
          pkgs.nil
          pkgs.alejandra
          # self' refers to the outputs defined in this perSystem block.
          self'.packages.deadnix
          # --- NEW: Agenix CLI tool ---
          inputs.agenix.packages.${pkgs.system}.default
        ];
      };
    };
}
