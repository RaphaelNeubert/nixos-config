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
    wiremix
    wev
    git
    python3
    xournalpp
    libreoffice-qt
    grimblast
    wl-clipboard # like xclip
    wlr-randr # like xrandr
    rofi
    nixfmt
    brave
    ripgrep # for neovim - telescope
    lazygit
    qlcplus
    texlive.combined.scheme-full
    ghostscript
    unzip
    awww # wallpaperd
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
    bluetui
    file
    fd
    eza
    bat
    zoxide
    fzf
    opencode
    inkscape
  ];
}
