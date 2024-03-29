{ inputs, lib, config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        gtk-layer-shell = true;
        layer = "top";
        position = "top";
        output = [ "eDP-1" "HDMI-A-1" ];
        height = 35;
        spacing = 4;
        margin-top = 5;
        margin-bottom = 1;
        modules-left = [ "custom/power" "wlr/workspaces" "hyprland/windows" ];
        modules-right = [
          "idle_inhibitor"
          "bluetooth"
          "network"
          "pulseaudio"
          "cpu"
          "memory"
          "disk"
          "temperature"
          "battery"
          "tray"
          "clock"
        ];
        "wlr/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "urgent" = "";
            "default" = "";
          };
        };
        "idle_inhibitor" = {
          format = "{icon} ";
          format-icons = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "tray" = {
          icon-size = 20;
          spacing = 10;
        };
        "clock" = {
          tooltip-format = ''
            <big>{:%B %Y}</big>
            <tt><small>{calendar}</small></tt>'';
          format = " {:%H:%M}";
          format-alt = " {:%a %b %d, %G}";
        };
        "cpu" = {
          interval = 5;
          format = " {usage}%";
        };
        "memory" = {
          interval = 10;
          format = " {used:0.1f}G";
        };
        "backlight" = {
          format = "{icon} {percent}%";
          format-icons = [ "" "" ];
        };
        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon} {time}";
          format-full = "";
          format-icons = [ "" "" "" "" "" ];
        };
        "disk" = {
          interval = 30;
          format = " {free}";
        };
        "network" = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "Connected  ";
          tooltip-format = "{ifname} via {gwaddr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          on-click-right = "nm-applet --no-agent";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-bluetooth-muted = "{icon} {format_source}";
          format-muted = "{format_source}";
          format-source = "";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
        };
        "custom/power" = {
          format = " ";
          on-click =
            "${pkgs.rofi}/bin/rofi -show p -modi p:${pkgs.rofi-power-menu}/bin/rofi-power-menu -theme $HOME/.config/rofi/config.rasi";
          on-click-right = "${pkgs.rofi}/bin/rofi -show drun";
        };
        "temperature" = {
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = [ "" "" "" ];
        };
        "bluetooth" = {
          format = "  {status} ";
          format-disabled = "";
          format-connected = "  {num_connections} ";
          tooltip-format = "{controller_alias}	{controller_address}";
          tooltip-format-connected = ''
            {controller_alias}	{controller_address}

            {device_enumerate}'';
          tooltip-format-enumerate-connected =
            "{device_alias}	{device_address}";
          on-click = "blueman-manager";
        };
      };
    };
    style = ''
          * {
              border: none;
              border-radius: 0px;
              font-family: FuraMono Nerd Font;
              font-size: 13px;
              min-height: 0;
          }
          window#waybar {
              background-color: transparent;
              color: #CDD6F4;
              transition-property: background-color;
              transition-duration: .5s;
          }
          window#waybar.hidden {
              opacity: 0.2;
          }
          #workspaces button {
              background-color: transparent;
              color: #CDD6F4;
              border-radius: 20px;
          }
          /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
              background: #1f1f1f;
              color: #CDD6F4;
              border-bottom: 3px solid #CDD6F4;
          }
          #workspaces button.focused {
              background: #1f1f1f;
          }
          #workspaces button.focused:hover {
              background: #1f1f1f;
              color: #CDD6F4;
              border-bottom: 3px solid #CDD6F4;
          }
          #workspaces button.urgent {
              background-color: #eb4d4b;
          }
          #clock,
          #battery,
          #cpu,
          #memory,
          #disk,
          #temperature,
          #backlight,
          #network,
          #pulseaudio,
          #mpd,
          #custom-launcher,
          #custom-power,
          #custom-weather,
          #taskbar,
          #tray,
          #idle_inhibitor,
          #mpd {
              padding: 0 10px;
              color: #CDD6F4;
          }
          #window,
          #workspaces {
              margin: 0px 4px;
          }
          /* If workspaces is the leftmost module, omit left margin */
          .modules-left > widget:first-child > #workspaces {
              margin-left: 0px;
          }
          /* If workspaces is the rightmost module, omit right margin */
          .modules-right > widget:last-child > #workspaces {
              margin-right: 0px;
          }
          #clock {
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
              color: rgba(166, 227, 161, 1);
          }
          #battery {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
          }
          #battery.charging, #battery.plugged {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background: radial-gradient(circle, rgba(30, 30, 46,0.6) 65%, rgba(166, 227, 161, 0.5) 50%);
          }
          @keyframes blink {
              to {
                  background-color: #CDD6F4;
                  color: #000000;
              }
          }
          #battery.critical:not(.charging) {
              background-color: rgba(166, 227, 161, 0.8);
              color: rgb(72, 76, 100);
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }
          label:focus {
              background-color: #000000;
          }
          #cpu {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
          }
          #memory {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
          }
          #disk {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
          }
          #backlight {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
          }
          #network {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
          }
          #network.disconnected {
              background-color: rgba(30, 30, 46, 0.6);
              color: red;
          }
          #pulseaudio {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
          }
          #pulseaudio.muted {
              background-color: rgba(30, 30, 46, 0.6);
              color: red;
          }
          #mpd {
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(62deg, rgba(129, 200, 190, 0.2) 0%, rgba(30, 30, 46, 0) 100%);
              color: #c5cff5;
              border-radius: 20px;
              margin-right: 5px;
              margin-left: 5px;
          }
          #custom-media.custom-spotify {
              background-color: #8EC5FC;
              background-image: linear-gradient(62deg, #8EC5FC 0%, #E0C3FC 100%);
              color: #CDD6F4;
              border-radius: 20px;
              margin-right: 5px;
          }
          #custom-media.custom-vlc {
              background-color: #8EC5FC;
              background-image: linear-gradient(62deg, #8EC5FC 0%, #E0C3FC 100%);
              color: black;
              border-radius: 20px;
              margin-right: 5px;
          }
          #custom-power{
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
              font-size: 18px;
              border-radius: 0px 20px 20px 0px;
              margin-right: 5px;
          }
          #custom-launcher{
              color: #ef9f76;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(62deg, rgba(129, 200, 190, 0.2) 0%, rgba(30, 30, 46, 0) 100%);
              font-size: 20px;
              border-radius: 20px 0px 0px 20px;
              margin-left: 5px;
          }
          #custom-weather{
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
              font-size:13px;
          }
          #bluetooth {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
          }
          #taskbar{
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(62deg, rgba(30, 30, 46, 0.3) 0%, rgba(250, 179, 135, 0.1) 100%);
              border-radius: 0px 20px 20px 0px;
          }
          #temperature {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
          }
          #temperature.critical {
              color: #CDD6F4;
              background: rgb(17,17,27);
              background: radial-gradient(circle, rgba(30, 30, 46,0.6) 65%, rgba(235,77,75,0.5) 50%);
          }
          #tray {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
          }
          #tray > .passive {
              -gtk-icon-effect: dim;
              background-color: rgba(30, 30, 46, 0.6);
              color: #CDD6F4;
          }
          #tray > .needs-attention {
              -gtk-icon-effect: highlight;
              background-color: rgba(30, 30, 46, 0.6);
              color: #CDD6F4;
          }
          #idle_inhibitor {
              color: #CDD6F4;
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
              border-radius: 20px 0px 0px 20px;
          }
          #idle_inhibitor.activated {
              color: rgba(166, 227, 161, 1);
              background-color: rgba(30, 30, 46, 0.5);
              background-image: linear-gradient(180deg, rgba(30, 30, 46, 0.8) 1%, rgba(24, 25, 38, 0.9) 90%);
              border-radius: 20px 0px 0px 20px;
          }
    '';
  };
}
