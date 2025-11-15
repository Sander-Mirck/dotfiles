# modules/system/shell-aliases.nix
{
  config,
  pkgs,
  ...
}: {
  environment.shellAliases = {
    # Use a relative path for flake commands so it works from within the config dir.
    nrs = "sudo nixos-rebuild switch --flake .#${config.networking.hostName}";
    nrsu = "sudo nixos-rebuild switch --upgrade --flake .#${config.networking.hostName}";
    nrb = "sudo nixos-rebuild boot --flake .#${config.networking.hostName}";
    nrt = "sudo nixos-rebuild test --flake .#${config.networking.hostName}";

    # Nix garbage collection
    nrgc = "sudo nix-collect-garbage -d";

    # Utility aliases
    ll = "ls -la";
    update = "nrsu";
  };
}