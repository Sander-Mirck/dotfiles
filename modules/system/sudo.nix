# /modules/system/sudo.nix
# We request `globalOptions` instead of `options` to avoid conflict
{
  config,
  lib,
  globalOptions,
  ...
}: {
  # Use globalOptions to access your custom config
  security.sudo.extraRules = lib.mkIf globalOptions.enableUnsafeNoPassword [
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
