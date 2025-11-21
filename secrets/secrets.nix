let
  # 1. Your User Key (from ~/.ssh/id_ed25519.pub)
  sander = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINd5LCWjiX2hjKr+VD4yFcavZ4OmjHiS6DwQv3ggUO0N sandermirck@gmail.com";

  # 2. The System Key (The output you just got from the command above)
  laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKupC+pdH+LhxYfOZudB3D3FQrkpiJilh9swMbEtdldO root@laptop";

  all_users = [ sander ];
  all_systems = [ laptop ];
in
{
  "user-password.age".publicKeys = all_users ++ all_systems;
}
