# /etc/nixos/modules/system/boot.nix
{ config, pkgs, lib, ... }:

{
  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Early KMS for Intel to avoid GDM grey-screen and flicker
  boot.initrd.kernelModules = [ "i915" ];
  boot.initrd.availableKernelModules = lib.mkIf (config.boot.initrd.availableKernelModules != null) (
    config.boot.initrd.availableKernelModules ++ [ "i915" ]
  );

  # Prefer Wayland with GDM; keep X11 available but don’t force legacy "intel" DDX
  services.xserver.videoDrivers = [ "modesetting" ];

  # Ensure OpenGL/Mesa path and VAAPI are enabled for Intel
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [ intel-media-driver ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ intel-media-driver ];
  };

  # Boot hygiene
  boot.tmp.cleanOnBoot = true;
}
