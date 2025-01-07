{ pkgs, ... }:
{
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override {
    extraPkgs = pkgs: [
      pkgs.fftw
      pkgs.libsForQt5.qt5.qtwayland
    ];
  };
}
