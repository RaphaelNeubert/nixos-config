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
        "desktop" = {
          id = "T33LOQG-DU3JDXZ-TAAVCFE-TWQRWJN-TYYOUVC-FOUUUJA-HWKDXWB-GVXKDAX";
        };
        "desktop-gentoo" = {
          id = "KFUAMOW-PU22UBP-BWA5H4Z-WHIJDKB-MN4SKPM-ZCUNNVL-TSFATLQ-NCLGLA4";
        };
      };
      folders = {
        "tu" = {
          path = "/home/raphael/tu";
          devices = [ "desktop" "desktop-gentoo"];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "2592000";
            };
          };
        };
        "documents" = {
          path = "/home/raphael/documents";
          devices = [ "desktop" "desktop-gentoo"];
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
