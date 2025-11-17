# /config/options.nix
#
# This is your central control panel for configuration options.
# You can easily toggle features here without digging into other modules.

{
  # Allows passwordless sudo for the main user.
  # WARNING: This is insecure and should only be used in trusted environments.
  #
  # Type: boolean (true or false)
  enableUnsafeNoPassword = true;
}
