# modules/system/packages/cli-tools.nix
{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bat
    curl
    eza # Modern ls replacement
    fd
    git
    mtr
    ripgrep
    tmux
    tree
    unzip
    wget
    wl-clipboard
    fzf
    jq
    yq
    btop
    htop
    hddtemp
    nix-output-monitor
    smartmontools
    ghostty
    lazygit
    gnupg
    nmap
    pciutils
    usbutils
    wireshark
  ];
}