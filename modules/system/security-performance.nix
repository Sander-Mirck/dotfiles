# modules/system/security-performance.nix
{
  config,
  pkgs,
  lib,
  ...
}: {
  # Security limits
  security.pam.loginLimits = [
    {
      domain = "@users";
      type = "hard";
      item = "nofile";
      value = "8192";
    }
    {
      domain = "@users";
      type = "soft";
      item = "nofile";
      value = "4096";
    }
  ];

  # Entropy – modern kernels are fine, but if you want it:
  services.haveged.enable = true;

  # Enhanced security settings
  security = {
    # Disable root login by password (use sudo)
    sudo.execWheelOnly = true;
    
    # Enable DoS protection
    protectKernelImage = true;
    
    # Hide process information from other users
    hideProcessInformation = true;
    
    # Allow sudo without password for wheel group (convenient but less secure)
    sudo.wheelNeedsPassword = false;
  };

  # Performance tweaks
  boot.kernel.sysctl = {
    "kernel.watchdog_thresh" = 60;
    "vm.swappiness" = 10; # Reduce swap usage
    "vm.vfs_cache_pressure" = 50;
    "net.core.rmem_max" = 134217728;
    "net.core.wmem_max" = 134217728;
    "net.ipv4.tcp_rmem" = "4096 65536 134217728";
    "net.ipv4.tcp_wmem" = "4096 65536 134217728";
  };

  # Boot hygiene
  boot.tmp.cleanOnBoot = true;
  
  # ZRAM for better memory management
  zramSwap.enable = true;
  zramSwap.memoryPercent = 50;
}