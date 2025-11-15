# /modules/system/shell-aliases.nix
{
  config,
  pkgs,
  ...
}: {
  # Define convenient shell aliases for system management.
  environment.shellAliases = {
    # NixOS rebuild commands using the current host's configuration.
    nrs = "sudo nixos-rebuild switch --flake .#${config.networking.hostName}";
    nrsu = "sudo nixos-rebuild switch --upgrade --flake .#${config.networking.hostName}";
    nrb = "sudo nixos-rebuild boot --flake .#${config.networking.hostName}";
    nrt = "sudo nixos-rebuild test --flake .#${config.networking.hostName}";

    # Garbage collection.
    nrgc = "sudo nix-collect-garbage -d";

    # Common utilities.
    ll = "ls -la";
    update = "nrsu";
  };
}
