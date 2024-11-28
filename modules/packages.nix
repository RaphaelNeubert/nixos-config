{
  config,
  pkgs,
  inputs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    neovim
    wget
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
    brave
    ripgrep # for neovim - telescope
    lazygit
    qlcplus
    texlive.combined.scheme-medium
    unzip
    swww # wallpaperd
    mpv
    qimgv
  ];
}
