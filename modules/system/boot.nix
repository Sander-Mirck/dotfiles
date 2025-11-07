# /etc/nixos/modules/system/boot.nix
{ config, pkgs, ... }:

{
  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- KERNEL MODULES FIX FOR GDM GREY SCREEN ---
  #
  # Force the Intel graphics driver to load in the initrd. This ensures the
  # GPU is fully initialized before the login manager starts, preventing the
  # grey screen issue on fast logins.
  boot.initrd.availableKernelModules = [ "i915" ];

  # Also, explicitly tell the X server to use the Intel driver.
  services.xserver.videoDrivers = [ "intel" ];
  
  # Security improvements
  # Boot security
  boot.tmp.cleanOnBoot = true;
  # Enable systemd watchdog to detect and automatically reboot when the system hangs
  boot.kernel.sysctl."kernel.watchdog_thresh" = 60;
  services.systemd.enableEmergencyMode = true;
}