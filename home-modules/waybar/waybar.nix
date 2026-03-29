{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 34;
        layer = "top";
        spacing = 16;
        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "battery"
          "backlight"
          "wireplumber"
          "memory"
          "cpu"
          "hyprland/language"
          "network#signal"
          "bluetooth"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          #all-outputs = true;
          on-click = "activate";
          format-icons = {
            active = " 󱎴";
            default = "󰍹";
          };
          #persistent-workspaces = {
          #        "1" = [ ];
          #        "2" = [ ];
          #        "3" = [ ];
          #        "4" = [ ];
          #        "5" = [ ];
          #        "6" = [ ];
          #        "7" = [ ];
          #        "8" = [ ];
          #        "9" = [ ];
          #};
        };
        "hyprland/window" = {
          seperate-outputs = true;
        };

        "hyprland/language" = {
          format-en = "EN";
          format-de = "DE";
        };
        "clock" = {
          interval = 1;
          format = "  {:%H:%M:%S    %d %b}";
          format-alt = "{:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>KW{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        "network" = {
          interval = 1;
          format = " {bandwidthUpBytes:>}  {bandwidthDownBytes:>}";
          #format-wifi = "  {signalStrength}%";
        };
        "network#signal" = {
          interval = 15;
          format-wifi = "{icon}";
          format-ethernet = " ";
          format-icons = [
            ""
            ""
            ""
          ];
          tooltip-format-wifi = "{signalStrength}% | {ipaddr}";
          tooltip-format-ethernet = "{ipaddr}";
        };

        "bluetooth" = {
          format-off = "";
          format-on = " ";
          format-connected = " {device_battery_percentage}%";
          on-click = "bluetoothctl connect 38:8F:30:82:6E:BE";
          on-click-right = "kitty -e bluetui";
        };
        "memory" = {
          interval = 10;
          format = " {percentage}%";
        };
        "cpu" = {
          interval = 10;
          format = " {usage}%";
        };
        "wireplumber" = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        "battery" = {
          interval = 60;
          states = {
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = "{capacity}%";
          format-plugged = "{capacity}%";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "backlight" = {
          #"device": "intel_backlight",
          format = "{icon} {percent}%";
          format-icons = [
            ""
            ""
          ];
        };
      };
    };
    style = builtins.readFile ./waybar-style.css;
  };
}
