# modules/system/security-performance.nix
{ config, pkgs, lib, ... }:

{
  # Security enhancements
  security.pam.loginLimits = [
    {
      domain = "@users";
      type = "hard";
      item = "nofile";
      value = "4096";
    }
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.haveged.enable = true;

  # Performance tweaks
  boot.kernel.sysctl."kernel.watchdog_thresh" = 60;
  boot.tmp.cleanOnBoot = true;
}
