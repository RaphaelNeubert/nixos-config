{ pkgs, ... }:
{
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      pkgs.fftw
      pkgs.libsForQt5.qt5.qtwayland
      pkgs.qt6.full
      pkgs.qt6.qtbase
      pkgs.qt6.qtwayland
      pkgs.wayland

      pkgs.zstd
    ];
  };
}
