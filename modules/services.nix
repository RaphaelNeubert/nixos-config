{ config, pkgs, ... }:

{
  services.locate.enable = true;
  services.udev.packages = [ pkgs.qlcplus ];
  services.printing.enable = true;
  services.avahi = {
    # for printer discovery
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
