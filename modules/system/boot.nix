# /etc/nixos/modules/system/boot.nix
{ config, pkgs, lib, ... }:

{
  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Early KMS for Intel to avoid GDM grey-screen and flicker
  boot.initrd.kernelModules = [ "i915" ];
  boot.initrd.availableKernelModules = lib.mkAfter [ "i915" ];

  # Prefer Wayland with GDM; keep X11 available but don’t force legacy "intel" DDX
  services.xserver.videoDrivers = [ "modesetting" ];

  # Ensure OpenGL/Mesa path and VAAPI are enabled for Intel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;  # only if you need 32-bit (e.g., Steam, some Wine)
    # extraPackages = with pkgs; [ ]; # optional: add Vulkan/OpenCL drivers if needed
  };

  # Boot hygiene
  boot.tmp.cleanOnBoot = true;
}
