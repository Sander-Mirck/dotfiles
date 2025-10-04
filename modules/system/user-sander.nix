# User configuration for sander
{ ... }:

{
  users.users.sander = {
    isNormalUser = true;
    description = "Sander Mirck";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}