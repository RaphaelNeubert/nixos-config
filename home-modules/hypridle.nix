{
  config,
  pkgs,
  device,
  ...
}:
let
  isLaptop = device == "laptop";
  lockTimeout = if isLaptop then 900 else 3600;
  dpmsTimeout = if isLaptop then 1200 else 1800;
in
{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = lockTimeout;
          on-timeout = "hyprlock";
        }
        {
          timeout = dpmsTimeout;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
