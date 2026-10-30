{ pkgs, ... }:

{
  home.packages = [ (pkgs.callPackage ../pkgs/qlcplus-appimage.nix { }) ];
}
