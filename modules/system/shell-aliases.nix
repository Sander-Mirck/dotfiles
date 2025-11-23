# /modules/system/shell-aliases.nix
{
  config,
  pkgs,
  ...
}:
{
  environment.shellAliases = {
    # "switch" -> Apply the current configuration immediately
    switch = "nh os switch /home/sander/nixos";

    # "update" -> Update flake inputs (download new packages) AND switch
    update = "nh os switch --update /home/sander/nixos";

    # "cleanup" -> Delete old generations (garbage collection)
    cleanup = "nh clean all --keep 3";

    # "try" -> Build and activate config, but don't add to bootloader (good for testing breakage)
    try = "nh os test /home/sander/nixos";

    # ---------------------------------------------------------
    # Speed Aliases (3 letters, extremely fast)
    # ---------------------------------------------------------
    nos = "switch"; # (N)ix (O)S (S)witch
    nup = "update"; # (N)ix (UP)date
    ngc = "cleanup"; # (N)ix (G)arbage (C)ollect

    # ---------------------------------------------------------
    # Utilities
    # ---------------------------------------------------------
    ll = "ls -la";

    # Safety: Prevent accidental overwrites
    cp = "cp -i";
    mv = "mv -i";
    rm = "rm -i";
  };
}
