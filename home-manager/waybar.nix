{ config, lib, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar-hyprland;
    systemd = {
      enable = true;
    };
    style = ''
      	  * {
      	  border: none;
      	  border-radius: 0;
      	  font-family: FiraCode Nerd Font;
      	  font-size: 12pt;
            }

            window#waybar {
      	  background: transparent;
      	  color: white;
            }
            tooltip {
      	background: #080808;
      	border-radius: 25px;
      	border-width: 2px;
      	border-style: solid;
      	border-color: #303030;
            }
            #workspaces button {
      	  color: white;
      	  background: transparent;
            }
            #workspaces button.focused {
      	  color: lightgreen;
            }
            #workspaces button.urgent{
      	  animation-duration: 0.5s;
      	  animation-timing-function: linear;
      	  animation-iteration-count: infinite;
      	  animation-direction: alternate;
      	  border-radius: 7px;
            }
            #custom-power {
      	margin: 8px;
      	min-height: 12px;
      	min-width: 24px;
      	color: red;
            }
            #custom-media {
      	margin-left: 10px;
            }
            #tray{
      	margin-right: 20px;
            }
            #language, #network, #pulseaudio, #battery, #backlight{
      	margin-right: 40px;
            }
            #pulseaudio.muted{
      	color:darkred;
            }
            #network.disconnected{
      	color:red;
            }
            #battery.critical{
      	color:red;
            }
            #battery.warning{
      	color:orange;
            }
            #battery{
      	color:green;
            }
            #network.wifi{
      	color:green;
            }
            #network.vpn{
      	color:gray;
            }
            #network.disconnected{
      	color:red;
            }
    '';
    settings = {
      mainBar = {
        gtk-layer-shell = false;
        modules-left = [ "custom/power" "wlr/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "network" "pulseaudio" "battery" "backlight" ];
        "wlr/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = " ";
            "2" = "爵";
            "3" = " ";
            "4" = " ";
            "5" = " ";
            "6" = "缾";
            "7" = "阮";
          };
          persistent_workspaces = {
            "1" = [ "eDP-1" ];
            "2" = [ "eDP-1" ];
            "3" = [ "eDP-1" ];
            "4" = [ "eDP-1" ];
            "5" = [ "eDP-1" ];
            "6" = [ "eDP-1" ];
            "7" = [ "eDP-1" ];
          };
        };
        "tray" = {
          icon-size = 13;
        };
        "network" = {
          interval = 6;
          format-wifi = "";
          format-ethernet = "";
          format-disconnected = "⚠";
          tooltip-format = "{ifname}: {ipaddr}";
        };
        "pulseaudio" = {
          scroll-step = 2;
          format = "{icon}";
          format-muted = "";
          tooltip = true;
          format-tooltip = "{volume}%";
          format-icons = {
            headphone = "";
            hands-free = "וֹ";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" ];
          };
          on-click-right = "pavucontrol";
          on-click = "amixer -q sset Master toggle";
          on-scroll-up = "amixer -q sset Master 2%+";
          on-scroll-down = "amixer -q sset Master 2%-";
        };
        "battery" = {
          icon-size = 18;
          states = {
            warning = 30;
            critical = 15;
            full = 99;
          };
          format = "{icon}";
          format-warning = "{icon}";
          format-critical = "{icon}";
          format-charging = "";
          format-alt = "{icon}";
          format-full = "{icon}";
          tooltip = true;
          format-tooltip = "{capacity}% left: {timeTo}";
          format-icons = [ "" "" "" "" "" ];
        };
        "backlight" = {
          format = "{icon}{percent}";
          format-icons = [ "" "" ];
          tooltip = true;
          format-tooltip = "{percent}%";
          on-scroll-down = "brightnessctl -c backlight set 1%-";
          on-scroll-up = "brightnessctl -c backlight set +1%";
        };
        "clock" = {
          interval = 1;
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%H:%M}";
        };
        "custom/power" = {
          format = "⏻";
          on-click = pkgs.writeShellScript "power-menu" ''
            entries="Logout Hibernate Reboot Shutdown"

            selected=$(printf '%s\n' $entries | wofi --conf=$HOME/.config/wofi/config.power --style=$HOME/.config/wofi/style.widgets.css | awk '{print tolower($1)}')

            case $selected in
              logout)
                swaymsg exit;;
              hibernate)
            	exec systemctl hibernate;;
              reboot)
                exec reboot;;
              shutdown)
                exec systemctl poweroff -i;;
            esac
          '';
          tooltip = false;
        };

      };
    };
  };
}




