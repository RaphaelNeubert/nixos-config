{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    extraLuaFiles.config = ./hyprland.lua;
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    #x11.enable = true;
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 24;
  };
}
