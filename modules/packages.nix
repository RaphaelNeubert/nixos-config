{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    neovim
    wget
    kitty
    tree
    htop
    btop
    pulsemixer
    wev
    git
    python3
    xournalpp
    libreoffice-qt
    grimblast
    wl-clipboard # like xclip
    wlr-randr # like xrandr
    rofi-wayland
    nixfmt-rfc-style
    zathura
  ];
}
