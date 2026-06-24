{ ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "/home/raphael/.nix-profile/bin/start-hyprland";
        user = "raphael";
      };
    };
  };
}
