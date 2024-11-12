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
    key = "/home/raphael/.local/share/syncthing/key.pem";
    cert = "/home/raphael/.local/share/syncthing/cert.pem";
    settings = {
      devices = {
        "laptop" = {
          id = "NBIBOFA-WDPJGWW-UAGVRYA-7PLVFCU-SZ4MYL3-A2K4Q2Z-4V4H566-QNUV3AU";
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
        "documents" = {
          path = "/home/raphael/documents";
          devices = [ "laptop" ];
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600";
              maxAge = "2592000";
            };
          };
        };
        "fun" = {
          path = "/home/raphael/fun";
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
  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true";
}
