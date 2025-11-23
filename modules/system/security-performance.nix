# modules/system/security-performance.nix
{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Security limits
  security.pam.loginLimits = [
    {
      domain = "@users";
      type = "hard";
      item = "nofile";
      value = "4096";
    }
  ];

  # Performance tweaks
  boot.kernel.sysctl."kernel.watchdog_thresh" = 60;
  boot.tmp.cleanOnBoot = true;
}
