{ config, pkgs, ... }:

{
  #home.packages = with pkgs; [
  #  font-awesome
  #];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      exec-once = [
        "waybar"
        "swww-daemon"
      ];
      # preferred - use the display's preferred size and refresh rate
      # auto - automatically place monitor (by default on the right of existing ones)
      monitor = [
        ",preferred,auto,1"
        "DVI-D-2,preferred,auto-left,1"
        "HDMI-A-1,preferred,auto-right,1"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 2;
        layout = "master";
        #"col.active_border" = "rgba(ff453aee) rgba(ff9f0aee) 45deg"; #sunset
        #"col.active_border" = "rgba(cc0000ee) rgba(ff6600ee) 45deg"; # magma burst
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg"; # cyan green
        #"col.active_border" = "rgba(00ffffff) rgba(9933ffff) 45deg"; # aurora glow
      };
      input = {
        kb_layout = "us, de";
        kb_options = "caps:swapescape, altwin:swap_alt_win";
        repeat_rate = 50;
        repeat_delay = 300;
        touchpad = {
          natural_scroll = false;
        };
      };
      bind =
        [
          "$mod SHIFT, Return, exec, $terminal"
          "$mod, P, exec, rofi -show drun"
          "$mod SHIFT, C, killactive,"
          "$mod CTRL, delete, exit,"
          "$mod, Q, exec, hyprlock --immediate"
          "$mod, S, exec, hyprctl switchxkblayout current next"

          "$mod, W, exec, chromium --disable-gpu-compositing"
          "$mod, V, exec, $terminal -e pulsemixer"
          ", Print, exec, grimblast copy area"

          "$mod, M, fullscreen, 1"
          "$mod SHIFT, M, fullscreen, 0"
          "$mod, F, togglefloating"

          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          "$mod SHIFT, H, movewindow, l"
          "$mod SHIFT, L, movewindow, r"
          "$mod SHIFT, K, movewindow, u"
          "$mod SHIFT, J, movewindow, d"

          "$mod SHIFT, comma, movecurrentworkspacetomonitor, l"
          "$mod SHIFT, period, movecurrentworkspacetomonitor, r"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          )
        );
      # l: inhibitor ressistant, e: repeat on hold
      bindle = [
        ", XF86MonBrightnessUp, exec, brightnessctl set 1%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 1%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      misc = {
        new_window_takes_over_fullscreen = 1;
        enable_swallow = false;
        swallow_regex = "^(kitty)$";
        swallow_exception_regex = "^(?!zathura|xournalpp).*";

        disable_hyprland_logo = true;
      };
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    #x11.enable = true;
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 24;
  };
}
