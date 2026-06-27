{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.hyprlock.enable = true;
}
