{ config, lib, pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = "(0,500)";
        height = 500;
        origin = "top-right";
        offset = "10x30";
        scale = 0;
        progress_bar = true;
        frame_color = "#8AADF4";
        separator_color = "frame";
        font = "Monospace 12";

      };
      urgency_low = {
        background = "#24273A";
        foreground = "#CAD3F5";
        timeout = 10;
      };
      urgency_normal = {
        background = "#24273A";
        foreground = "#CAD3F5";
        timeout = 10;
      };

      urgency_critical = {
        background = "#24273A";
        foreground = "#CAD3F5";
        frame_color = "#F5A97F";
        timeout = 0;
      };

    };
  };
}
