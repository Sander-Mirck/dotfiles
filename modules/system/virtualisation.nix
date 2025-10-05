{ config, pkgs, lib, ... }:

{
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

  virtualisation.libvirtd.onBoot = "start";
  virtualisation.libvirtd.onShutdown = "shutdown";

  users.users.sander.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    qemu
    virt-manager
    virt-viewer
    dnsmasq
  ];

  networking.firewall.allowedTCPPorts = [ 16509 ];
}
