{ config, pkgs, ... }:

{
  services.locate.enable = true;

  services.udev.packages = [ pkgs.qlcplus ];
}
