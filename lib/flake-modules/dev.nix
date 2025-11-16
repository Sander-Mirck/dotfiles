# /lib/flake-modules/dev.nix
# This flake module defines developer-centric outputs like formatters and shells.
{inputs, ...}: {
  perSystem = {
    config,
    self',
    pkgs,
    ...
  }: {
    # Default formatter for `nix fmt`.
    formatter = pkgs.alejandra;

    # Linter to detect dead code.
    packages.deadnix = inputs.deadnix.packages.default;

    # Development shell with essential tools.
    devShells.default = pkgs.mkShell {
      packages = [
        pkgs.git
        pkgs.nil
        pkgs.alejandra
        self'.packages.deadnix
      ];
    };
  };
}
