# modules/home-manager/programs/git.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.git = {
    enable = true;

    # Use a version of Git that includes the libsecret helper.
    package = pkgs.git.withPackages (ps: [ ps.libsecret ]);

    settings = {
      user.name = "Sander Mirck";
      user.email = "mail@sandermirck.nl.eu.org";
      core.editor = "nvim";
      pull.rebase = true;
    };

    # This is the corrected section.
    # We use `extraConfig` to set the credential helper, which integrates
    # with desktop keyrings like KDE Wallet.
    extraConfig = {
      credential.helper = "libsecret";
    };
  };
}
