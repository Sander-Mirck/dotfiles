# modules/system/shell-aliases.nix
{
  config,
  pkgs,
  ...
}: {
  environment.shellAliases = {
    # laptop rebuild commands
    nrs = "sudo nixos-rebuild switch --flake /etc/nixos#laptop";
    nrsu = "sudo nixos-rebuild switch --upgrade --flake /etc/nixos#laptop";
    nrb = "sudo nixos-rebuild boot --flake /etc/nixos#laptop";
    nrt = "sudo nixos-rebuild test --flake /etc/nixos#laptop";

    # Nix garbage collection
    nrgc = "sudo nix-collect-garbage -d";
    nix-update = "sudo nixos-rebuild switch --flake /etc/nixos#laptop --upgrade";

    # Utility aliases
    ll = "ls -la";
    update = "nix-update";
  };
}
