{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    syncthing
  ];
  services.syncthing = {
    enable = true;
    dataDir = "/home/raphael"; # default sync dir
    openDefaultPorts = true;
    configDir = "/home/raphael/.config/syncthing";
    user = "raphael";
    group = "users";
    guiAddress = "0.0.0.0:8384";
    overrideDevices = true;
    overrideFolders = true;
    settings = {
      devices = {
        "laptop" = {
          id = "SSYZN67-EJGYLJB-TIZI6BX-H25UHEU-NO3EC2V-RHQN2ZC-X6HHVWS-5LM7XAX";
        };
      };
      folders = {
        "tu" = {
          path = "/home/raphael/tu";
          devices = [ "laptop" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "2592000";
            };
          };
        };
      };
    };
  };
}
