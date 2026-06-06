{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
    # nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    nvidia.open = false;
  };
}
