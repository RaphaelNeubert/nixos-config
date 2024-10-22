
{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = ["nvidia"]; 
  hardware = { 
    graphics.enable = true; 
    nvidia.modesetting.enable = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidia.open = false;
  };
}
