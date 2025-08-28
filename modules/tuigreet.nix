{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tuigreet
  ];
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time -r --cmd Hyprland";
        user = "raphael";
      };
    };
  };
}
