# modules/system/shell-aliases.nix
{ config, pkgs, ... }:

{
  environment.shellAliases = {
    # laptop rebuild commands
    nrs = "sudo laptop-rebuild switch --flake /etc/laptop#laptop";
    nrsu = "sudo laptop-rebuild switch --upgrade --flake /etc/laptop#laptop";
    nrb = "sudo laptop-rebuild boot --flake /etc/laptop#laptop";
    nrt = "sudo laptop-rebuild test --flake /etc/laptop#laptop";

    # Nix garbage collection
    nrgc = "sudo nix-collect-garbage -d";
    nix-update = "sudo laptop-rebuild switch --flake /etc/laptop#laptop --upgrade";

    # Utility aliases
    ll = "ls -la";
    update = "nix-update";
  };
}
