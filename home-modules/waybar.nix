{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 34;
        layer = "top";
        spacing = 16;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [
          "network"
          "battery"
          "backlight"
          "wireplumber"
          "memory"
          "cpu"
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
            "󰤟 "
            "󰤢 "
            "󰤢 "
            ""
          ];
          tooltip-format-wifi = "{signalStrength}% | {ipaddr}";
          tooltip-format-ethernet = "{ipaddr}";
        };

        "bluetooth" = {
          format-off = "";
          format-on = " ";
          format-connected = " ";
          on-click = "bluetoothctl connect 38:8F:30:82:6E:BE";
        };
        "memory" = {
          interval = 10;
          format = "  {percentage}%";
        };
        "cpu" = {
          interval = 10;
          format = "  {usage}%";
        };
        "wireplumber" = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = [
            " "
            " "
          ];
        };
        "battery" = {
          interval = 60;
          states = {
            warning = 30;
            critical = 20;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
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
    style = ''
                                      * {
                                        /* `otf-font-awesome` is required to be installed for icons */
                                        font-family: FontAwesome, Roboto, Helvetica, Arial, sans-serif;
                                        font-size: 13px;
                                    }

                                    window#waybar {
                                        background-color: rgba(43, 48, 59, 0.5);
                                        color: #ffffff;
                                        transition-property: background-color;
                                        transition-duration: .5s;
                                    }
                                    #workspaces {
                                    	background-color: #333333;
                              	}
                                    #workspaces button.active {
                                    	background-color: #535454;
                                    	color: #ecd3a0;
                        		/*
                                    	padding-left: 3px;
                                    	padding-right: 3px;
                        		*/
                                    	font-family: Iosevka Nerd Font;
                                    	font-weight: bold;
                                    	font-size: 12px;
      				/*
                                    	margin-left: 3px;
                                    	margin-right: 3px;
      				*/
                                    transition: all 0.5s cubic-bezier(0.55, -0.68, 0.48, 1.68);
                                    }
                                    #bluetooth.connected { 
                                    	color: #5291f7;
                                    }
            			#battery.critical { 
            				color: #ff6e5e;
            			}
            			#battery.warning { 
            				color: #ffae5e;
            			}
    '';
  };
}
