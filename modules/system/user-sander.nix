# User configuration for sander
{ config, pkgs, ... }:

{
  users.users.sander = {
    isNormalUser = true;
    description = "Sander Mirck";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    
    # Security: Set password requirements
    initialPassword = "temp";  # Change this immediately after first login
    openssh.authorizedKeys.keys = [ ];  # Add your SSH public keys here
  };
  
  # Security settings
  security.pam.loginLimits = [
    {
      domain = "@users";
      type = "hard";
      item = "nofile";
      value = "4096";
    }
  ];
}