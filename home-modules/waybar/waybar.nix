{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    # Waybar 0.15 still sends legacy dispatches; our Hyprland config uses Lua.
    package = pkgs.waybar.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        # Adapted from upstream e17c0d9f for the workspace code in 0.15.0.
        (pkgs.writeText "waybar-hyprland-lua-workspace-clicks.patch" ''
          --- a/src/modules/hyprland/workspace.cpp
          +++ b/src/modules/hyprland/workspace.cpp
          @@ -71,20 +71,20 @@
               try {
                 if (id() > 0) {  // normal
                   if (m_workspaceManager.moveToMonitor()) {
          -          m_ipc.getSocket1Reply("dispatch focusworkspaceoncurrentmonitor " + std::to_string(id()));
          +          m_ipc.getSocket1Reply("/dispatch hl.dsp.focus({ workspace = \"" + std::to_string(id()) + "\", on_current_monitor = true })");
                   } else {
          -          m_ipc.getSocket1Reply("dispatch workspace " + std::to_string(id()));
          +          m_ipc.getSocket1Reply("/dispatch hl.dsp.focus({ workspace = \"" + std::to_string(id()) + "\" })");
                   }
                 } else if (!isSpecial()) {  // named (this includes persistent)
                   if (m_workspaceManager.moveToMonitor()) {
          -          m_ipc.getSocket1Reply("dispatch focusworkspaceoncurrentmonitor name:" + name());
          +          m_ipc.getSocket1Reply("/dispatch hl.dsp.focus({ workspace = \"name:" + name() + "\", on_current_monitor = true })");
                   } else {
          -          m_ipc.getSocket1Reply("dispatch workspace name:" + name());
          +          m_ipc.getSocket1Reply("/dispatch hl.dsp.focus({ workspace = \"name:" + name() + "\" })");
                   }
                 } else if (id() != -99) {  // named special
          -        m_ipc.getSocket1Reply("dispatch togglespecialworkspace " + name());
          +        m_ipc.getSocket1Reply("/dispatch hl.dsp.workspace.toggle_special(\"" + name() + "\")");
                 } else {  // special
          -        m_ipc.getSocket1Reply("dispatch togglespecialworkspace");
          +        m_ipc.getSocket1Reply("/dispatch hl.dsp.workspace.toggle_special()");
                 }
                 return true;
               } catch (const std::exception& e) {
        '')
      ];
    });
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
