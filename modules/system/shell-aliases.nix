# modules/system/shell-aliases.nix
{ config, pkgs, ... }:

{
  environment.shellAliases = {
    # NixOS rebuild commands
    nrs = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    nrsu = "sudo nixos-rebuild switch --upgrade --flake /etc/nixos#nixos";
    nrb = "sudo nixos-rebuild boot --flake /etc/nixos#nixos";
    nrt = "sudo nixos-rebuild test --flake /etc/nixos#nixos";

    # Nix garbage collection
    nrgc = "sudo nix-collect-garbage -d";
    nix-update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos --upgrade";

    # Utility aliases
    ll = "ls -la";
    update = "nix-update";
  };
}
