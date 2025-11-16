# modules/system/sudo.nix
{
  config,
  lib,
  ...
}: let
  # Set this to false for security in production
  enableUnsafeNoPassword = false; # Just use a plain boolean here
in {
  security.sudo.extraRules = lib.mkIf enableUnsafeNoPassword [
    {
      users = ["sander"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
