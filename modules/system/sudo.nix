# /modules/system/sudo.nix

# Add `options` to the function arguments here
{
  config,
  lib,
  options,
  ...
}:
{
  # Use the value directly from your new options file.
  # The `let` block is no longer needed.
  security.sudo.extraRules = lib.mkIf options.enableUnsafeNoPassword [
    {
      users = [ "sander" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
