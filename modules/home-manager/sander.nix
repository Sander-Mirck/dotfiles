{ config, pkgs, unstable, ... }:

{
  programs.home-manager.enable = true;
  home.username = "sander";
  home.homeDirectory = "/home/sander";
  home.stateVersion = "25.05";

  home.packages = with unstable; [
    ani-cli
    
  ];

  programs.git = {
    enable = true;
    userName = "Sander Mirck";
    userEmail = "sandermirck@gmail.com";
  };

}