{
  config,
  pkgs,
  lib,
  ...
}: {
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

  virtualisation.libvirtd.onBoot = "start";
  virtualisation.libvirtd.onShutdown = "shutdown";

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    dnsmasq
  ];

  networking.firewall.allowedTCPPorts = [16509];
}
