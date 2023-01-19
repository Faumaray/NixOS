{ inputs, lib, config, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    recommendedEnvironment = true;
    systemdIntegration = true;
    extraConfig = ''
      monitor=,preferred,auto,1
            # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      # exec-once = waybar & hyprpaper & firefox

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us,ru
          kb_variant =
          kb_model =
          kb_options = grp:alt_shift_toggle
          kb_rules =

          follow_mouse = 1
          numlock_by_default=1
          touchpad {
              natural_scroll = no
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 5
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(1affffee)
          col.inactive_border = rgba(595959aa)

          layout = dwindle
      }

      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 10
          blur = yes
          blur_size = 3
          blur_passes = 1
          blur_new_optimizations = on
          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      device:epic mouse V1 {
          sensitivity = -0.5
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      windowrule = float, file_progress
      windowrule = float, confirm 
      windowrule = float, dialog 
      windowrule = float, download 
      windowrule = float, notification 
      windowrule = float, error 
      windowrule = float, splash
      windowrule = float, confirmreset
      windowrule = float, title:Open file
      windowrule = float, title:branchdialog
      windowrule = float, viewnior
      windowrule = float, file-roller 
      windowrule = float, title:^(Media viewer)$
      windowrule = float, title:^(Volume Control)$
      windowrule = float, title:^(Picture-in-Picture)$
      windowrule = float, type:^(dialog)$
      windowrule = float, type:^(launcher)$
      windowrule = float, type:^(popup)$
      windowrule = float, type:^(indicator)$
      windowrule = float, title:^(Ripcord Voice Chat)$
      windowrulev2 = float,xwayland:1
      windowrule = opacity 0.8,class:foot
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod, Return, exec, footclient -t foot-direct
      bind = $mainMod SHIFT, Q, killactive, 
      bind = $mainMod, M, exit, 
      bind = $mainMod, E, exec, dolphin
      bind = $mainMod, SPACE, togglefloating, 
      bind = $mainMod, F, fullscreen
      bind = $mainMod, D, exec, wofi --show drun
      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod, J, togglesplit, # dwindle

      # Move focus with mainMod + arrow keys
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10

      bind=,PRINT, exec, hyprland-interactive-screenshot
      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      bind=,XF86AudioRaiseVolume,exec, amixer -q sset Master 2%+
      bind=,XF86AudioLowerVolume,exec, amixer -q sset Master 2%-
      bind=,XF86AudioMute,exec, amixer -q sset Master toggle
      bind=,XF86MonBrightnessUp,exec,light -A 10
      bind=,XF86MonBrightnessDown,exec,light -U 10

      bind=$mainMod,R,submap,resize # will switch to a submap called resize
      submap=resize # will start a submap called "resize"
      #
      bind=,right,resizeactive,10 0
      bind=,left,resizeactive,-10 0
      bind=,up,resizeactive,0 -10
      bind=,down,resizeactive,0 10
      #
      bind=,l,resizeactive,10 0
      bind=,h,resizeactive,-10 0
      bind=,k,resizeactive,0 -10
      bind=,j,resizeactive,0 10
      #
      #
      #
      bind=,escape,submap,reset # use reset to go back to the global submap
      #
      bind=,print,exec,grim - | swappy -f -
      bind=SHIFT,print,exec,grim -g "$(slurp)" - | swappy -f -    
      exec-once=xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2
      exec-once=NVIM_LISTEN_ADDRESS=/tmp/nvim-socket nvim --headless
      exec-once=foot -t foot-direct --server
      exec-once = hyprpaper
      '';
  };
}
