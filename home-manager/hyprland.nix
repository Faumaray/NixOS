{ lib, config, pkgs, ... }:
{
  programs.hyprland.enable = true;
  home.file.".config/hypr/hyprland.conf".text = ''
    #exec-once=dunst
    #exec-once=wpaperd
    #exec-once=/home/faumaray/.config/eww/bar/launch_bar
    #exec-once=waybar -c /home/faumaray/.config/waybar/hypr-config
    #exec-once=dbus-run-session /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
    #exec-once=systemctl --user import-environment DISPLAY WAYLAND_DISPLAY
    exec-once=NVIM_LISTEN_ADDRESS=/tmp/nvim-socket nvim --headless
    #exec-once=emacs --daemon
    # This is an example Hyprland config file.
    # Syntax is the same as in Hypr, but settings might differ.
    #
    # Refer to the wiki for more information.

    monitor=eDP-1,1920x1080@60,0x0,1
    #monitor=eDP-1,addreserved,15,0,0,0
    workspace=DP-1,1

    input {
        kb_layout=us,ru
        kb_options=grp:alt_shift_toggle
        follow_mouse=2
        numlock_by_default=1
    }
    input:touchpad {
        disable_while_typing=1
    }

    general {
        max_fps=60 # deprecated, unused
        sensitivity=0.25
        main_mod=SUPER
        sensitivity=1.0   
        gaps_in=5
        gaps_out=5
        border_size=2
        col.active_border=0x66ee1111
        col.inactive_border=0x66333333
        no_border_on_floating=1

        apply_sens_to_raw=0 # do not apply the sensitivity to raw input (e.g. used by games where you aim)

        damage_tracking=full # leave it on full unless you hate your GPU and want to make it suffer
    }

    decoration {
        rounding=10
        blur=1
        blur_size=3 # minimum 1
        blur_passes=1 # minimum 1, more passes = more resource intensive.
        # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
        # if you want heavy blur, you need to up the blur_passes.
        # the more passes, the more you can up the blur_size without noticing artifacts.
    }


    animations {
        enabled=1
        animation=windows,1,7,default
        animation=borders,1,10,default
        animation=fadein,1,10,default
        animation=workspaces,1,6,default
    }

    dwindle {
        pseudotile=0 # enable pseudotiling on dwindle
    }

    # example window rules
    # for windows named/classed as abc and xyz
    #windowrule=RULE,TITLE\CLASS(RegEx)
    windowrule=float,^launcher$
    windowrule=workspace 5 silent,com.github.alainm23.planner
    windowrule=workspace 5 silent,(.*?Obsidian.*)
    windowrule=opacity 0.75,nvim-qt

    # example binds
    bind=SUPERSHIFT,Return,exec,terminology -B
    bind=SUPER,Return,exec,alacritty
    bind=SUPERSHIFT,E,exec,nvim-qt
    bind=SUPERSHIFT,Q,killactive
    bind=SUPERSHIFT,cyrillic_shorti,killactive
    bind=SUPER,M,exit,
    bind=SUPERSHIFT,F,togglefloating,
    bind=SUPER,D,exec,alacritty --class=launcher -e /usr/bin/sway-launcher-desktop
    bind=SUPER,cyrilic_ve,exec,alacritty --class=launcher -e /usr/bin/sway-launcher-desktop
    bind=SUPER,P,pseudo,

    bind=SUPER,h,movefocus,l
    bind=SUPER,l,movefocus,r
    bind=SUPER,k,movefocus,u
    bind=SUPER,j,movefocus,d
    bind=SUPER,cyrillic_er,movefocus,l
    bind=SUPER,cyrillic_de,movefocus,r
    bind=SUPER,cyrillic_el,movefocus,u
    bind=SUPER,cyrillic_o,movefocus,d

    bind=SUPER,1,workspace,1
    bind=SUPER,2,workspace,2
    bind=SUPER,3,workspace,3
    bind=SUPER,4,workspace,4
    bind=SUPER,5,workspace,5
    bind=SUPER,6,workspace,6
    bind=SUPER,7,workspace,7
    bind=SUPER,8,workspace,8
    bind=SUPER,9,workspace,9
    bind=SUPER,0,workspace,10

    bind=SUPERSHIFT,exclam,movetoworkspacesilent,1
    bind=SUPERSHIFT,at,movetoworkspacesilent,2
    bind=SUPERSHIFT,numbersign,movetoworkspacesilent,3
    bind=SUPERSHIFT,dollar,movetoworkspacesilent,4
    bind=SUPERSHIFT,percent,movetoworkspacesilent,5
    bind=SUPERSHIFT,asciicircum,movetoworkspacesilent,6
    bind=SUPERSHIFT,ampersand,movetoworkspacesilent,7
    bind=SUPERSHIFT,asterisk,movetoworkspacesilent,8
    bind=SUPERSHIFT,parenleft,movetoworkspacesilent,9
    bind=SUPERSHIFT,parenright,movetoworkspacesilent,10

    bind=,XF86AudioRaiseVolume,exec, amixer -q sset Master 2%+
    bind=,XF86AudioLowerVolume,exec, amixer -q sset Master 2%-
    bind=,XF86AudioMute,exec, amixer -q sset Master toggle
    bind=,XF86MonBrightnessUp,exec,light -A 10
    bind=,XF86MonBrightnessDown,exec,light -U 10
    bind=,XF86AudioPlay,exec,playerctl play-pause
    bind=,XF86AudioNext,exec,playerctl next
    bind=,XF86AudioPrev,exec,playerctl previous

    bind=SUPER,R,submap,resize # will switch to a submap called resize

    submap=resize # will start a submap called "resize"

    bind=,right,resizeactive,10 0
    bind=,left,resizeactive,-10 0
    bind=,up,resizeactive,0 -10
    bind=,down,resizeactive,0 10

    bind=,l,resizeactive,10 0
    bind=,h,resizeactive,-10 0
    bind=,k,resizeactive,0 -10
    bind=,j,resizeactive,0 10



    bind=,escape,submap,reset # use reset to go back to the global submap

    submap=reset # will reset the submap, meaning end the current one and return to the global one.

    bind=,print,exec,grim - | swappy -f -
    bind=SHIFT,print,exec,grim -g "$(slurp)" - | swappy -f -
  '';


}
