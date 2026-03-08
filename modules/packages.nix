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
    rofi
    nixfmt-rfc-style
    brave
    ripgrep # for neovim - telescope
    lazygit
    qlcplus
    texlive.combined.scheme-full
    unzip
    swww # wallpaperd
    mpv
    qimgv
    bitwarden-cli
    direnv
    wgetpaste
    nix-index
    lsof
    usbutils
    ### basic developement things
    gcc
    gnumake
    bear
    ###
    anki-bin
    vifm
    bc
    man-pages
    man-pages-posix
    eduvpn-client
    home-manager
    localsend
    uv
  ];
}
