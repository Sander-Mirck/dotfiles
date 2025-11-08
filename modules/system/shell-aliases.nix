# modules/system/shell-aliases.nix
{ config, pkgs, ... }:

{
  environment.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    nrsu = "sudo nixos-rebuild switch --upgrade --flake /etc/nixos#nixos";
    nrb = "sudo nixos-rebuild boot --flake /etc/nixos#nixos";
    nrt = "sudo nixos-rebuild test --flake /etc/nixos#nixos";
    nrgc = "sudo nix-collect-garbage -d";
    nix-update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos --upgrade";
    ll = "ls -la";
    update = "nix-update";
  };
}
