{
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "eDP-1,1920x1080@60,0x0,1";
      exec-once = ["waybar" "nm-applet"];
    };
  };
}
