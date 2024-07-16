{ pkgs, config, ... }:
let
  ut = "${pkgs.scripts}/bin/ut";
  change-wallpaper = "${pkgs.scripts}/bin/chpaper";
  cf = "${pkgs.scripts}/bin/cf";

in
{

  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
    };
    xwayland.enable = true;
    settings = {

      source = "~/testfolder/conf.conf";

      exec-once = [

        "hyprctl setcursor ${config.gtk.cursorTheme.name} 29"

        # sort files
        "${pkgs.scripts}/bin/filecheck"

        # check battery level
        "${ut} bat_level"

        "[workspace special:terminal silent]  kitty -1 --title Main --class=main --listen-on=unix:@mykitty zellij -s main"
      ];

      monitor = [

        "HDMI-A-1,preferred,auto,auto"

        "eDP-1,  1920x1080,  0x0,   1"

      ];

      # wallpaper
      exec = [
        "${change-wallpaper}"

        # change keyboard layout to colemak_dh
        "hyprctl switchxkblayout logitech-wireless-keyboard-pid:4023 1" # autostart kitty
        "hyprctl switchxkblayout at-translated-set-2-keyboard 1"
      ];


      input = {
        kb_layout = "us,us";
        kb_variant = ",colemak_dh";
        kb_model = " ";
        kb_options = "caps:backspace,shift:both_capslock";
        kb_rules = " ";

        follow_mouse = 1;

        touchpad = {
          natural_scroll = true;
        };

        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
      };

      general = {
        gaps_in = 5;
        gaps_out = 13;
        border_size = 2;
        resize_on_border = true;
        hover_icon_on_border = true;

        layout = "master";
      };

      decoration = {

        rounding = 10;
        inactive_opacity = 0.8;
        dim_inactive = true;
        dim_special = 0;

        blur = {

          special = false;

        };
      };

      cursor = {
      	inactive_timeout = 7;
      	hide_on_key_press = true;
      };



      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      binds = {
        workspace_back_and_forth = true;
      };

      dwindle = {
        pseudotile = true; # master switch for pseudotiling. 
        preserve_split = true; # you probably want this
      };

      master = {
        new_status = "master";
        new_on_top = true;
        special_scale_factor = 1.0;
      };

      gestures = {
        workspace_swipe = true;
      };

      # Example per-device config
      # device:epic-mouse-v1  = {
      #     sensitivity = -0.5
      # }

      # animation
      animation = [

        "windowsMove, 1, 0.5, default, slide"
        "windows, 0, 1, default"
        "fade, 0, 1, default"
        "border, 0, 1, default"
        "borderangle, 0, 1, default"
        "workspaces, 1, 0.5, default"

      ];


      windowrulev2 = [

        # launcher 
        "float, class:^(launcher)$"
        "size 30% 50%, class:^(launcher)$"
        "center, class:^(launcher)$"
        "dimaround, class:^(launcher)$"

        # mpv
        "workspace name:video, class:^(mpv)$"

        # firefox
        "workspace name:browser, class:^(firefox)$"

        #telegram
        "workspace name:telegram, class:^(org.telegram.desktop)$"

        # imv
        "float, class:^(imv)$"
        "size 99.5% 99%, class:^(imv)$"
        "center, class:^(imv)$"

        # playlist
        "float, class:^(mpv)$,title:^(playlist)$"
        "size 8% 14.2%, class:^(mpv)$,title:^(playlist)$"
        "move 90.8% 2.3%, class:^(mpv)$,title:^(playlist)$"
        "noinitialfocus, class:^(mpv)$,title:^(playlist)$"


        # kitty main
        "workspace special:terminal, class:^(main)$"

        # kitty
        "float, class:^(kitty)$"
        "size 98% 97%, class:^(kitty)$"
        "center, class:^(kitty)$"

      ];


      workspace = [

        # workspace on eDP-1
        "9, monitor:eDP-1"
        "0, monitor:eDP-1"

        # workspace on external monitor
        "1, monitor:HDMI-A-1,default:true"
        "2, monitor:HDMI-A-1"
        "3, monitor:HDMI-A-1"
        "6, monitor:HDMI-A-1"
        "7, monitor:HDMI-A-1"
        "8, monitor:HDMI-A-1"
        "name:browser, monitor:HDMI-A-1"
        "name:video, monitor:HDMI-A-1, gapsin:0, gapsout:0"
        "name:telegram, monitor:HDMI-A-1"

      ];



      "$mainMod" = "SUPER";

      bindr = [

        # hide waybar
        "SUPER, SUPER_L, exec, pkill waybar || waybar"

      ];

      # suspend laptop when lid is closed
      bindl = [
        ",code:248, exec, systemctl suspend"
      ];

      bind = [

        # show all active windows
        "$mainMod, TAB, exec, rofi -show window"


        # floating, fullscreen and focus
        "$mainModSHIFT, SPACE, fullscreen,1"
        "$mainMod, F, fullscreen,0"
        "$mainModSHIFT, F, fakefullscreen"
        "$mainMod, SPACE, cyclenext "
        "$mainModALT, SPACE, togglefloating"

        # general
        "$mainMod, RETURN, exec, ${cf} terminal"
        "$mainModALT, RETURN, movetoworkspace, special:terminal "
        "$mainModSHIFT,Q, killactive,"
        "$mainModSHIFT, E, exit,"
        "$mainMod, D, exec, rofi -show drun"
        "$mainMod, P, exec, ${pkgs.scripts}/bin/rofi-pass"

        # hyprland reload
        "$mainModSHIFT, c, exec, hyprctl reload"

        # flip screen orientation
        "ALT, R, exec, ${ut} flip_monitor"

        # swap master window 
        "$mainMod, M, layoutmsg, swapwithmaster master"
        "$mainModSHIFT, M, layoutmsg, focusmaster"

        # firefox
        "$mainMod, B, exec, ${cf} browser"
        "$mainModALT, Y, exec, ${cf} youtube_in_browser"
        "$mainModSHIFT, N , exec, ${cf} home_manager_search"
        "$mainMod, N, exec, ${cf} nixpkgs_search"

        # ytfzf
        "$mainMod, Y, exec, kitty @ --to unix:/tmp/mykitty launch --title youtube --type tab ytfzf -t -T kitty --detach -l -s -f --preview-side=right"
        "$mainMod, Y, workspace, special:terminal"
        "$mainMod, s, exec, kitty @ --to unix:/tmp/mykitty launch --title subscriptions --type tab ytfzf --detach -t -T kitty -l -s -f -c S --preview-side=right"
        "$mainMod, s, workspace, special:terminal"

        # scripts
        "$mainModSHIFT, B, exec, ${ut} my_bookmarks" # shows my bookmarks
        "$mainModSHIFT, Y, exec, ${ut} youtube_mpv" # play youtube links in mpv using ytfzf
        "$mainMod, R, exec, ${ut} power_menu" # power menu
        "$mainModALT, B, exec, ${ut} add_bookmark" # add a new bookmark to my bookmark file
        "$mainMod, C, exec, ~/.config/scripts/conf.sh"
        "$mainMod, O, exec, ${ut} toggle_screen" # toggle on/off laptop screen
        "$mainModSHIFT, P, exec, ${ut} my_playlist" # Select and plays my music playlists
        "$mainModSHIFT, S, exec, ${ut} change_default_sink" # changes default audio sink
        "$mainModSHIFT, D, exec, ${ut} connect_bluetooth" # connect to already paired bluetooth devices
        "$mainMod, M, exec, ${ut} play_videos" # Select and play videos from Videos directory

        # kitty in floating window
        "$mainModSHIFT, RETURN, exec, kitty -1 zellij -s main-float"

        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" # mute

        # Move focus with mainMod + vim keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # pin a window
        "$mainModALT, P, pin"

        # bring activewindow to top
        "$mainMod, A, bringactivetotop "

        # blur window
        "$mainMod, DELETE, togglespecialworkspace, blur"
        "$mainMod, DELETE, exec, hyprctl keyword decoration:blur:special true"

        # disable inactive window opacity and dim
        "$mainModSHIFT, O, exec, hyprctl keyword decoration:dim_inactive false"
        "$mainModSHIFT, O, exec, hyprctl keyword decoration:inactive_opacity 1"

        # brightness
        ",XF86MonBrightnessDown,exec,${pkgs.light}/bin/light -U 10"
        ",XF86MonBrightnessUP,exec,${pkgs.light}/bin/light -A 10"

        # move window with vim keys
        "$mainModSHIFT, H, movewindow, l"
        "$mainModSHIFT, L, movewindow, r"
        "$mainModSHIFT, K, movewindow, u"
        "$mainModSHIFT, J, movewindow, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, name:video"
        "$mainMod, 5, workspace, name:telegram"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, name:video"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        #specialworkspace (scratchpad in sway)
        "$mainModSHIFT, MINUS, movetoworkspace, special"
        "$mainMod, MINUS, togglespecialworkspace"
        "$mainMod, MINUS, exec, hyprctl keyword decoration:blur:special false"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"

      ];

      binde = [

        # resizewindow
        "$mainMod,right,resizeactive,10 0"
        "$mainMod,left,resizeactive,-10 0"
        "$mainMod,up,resizeactive,0 -10"
        "$mainMod,down,resizeactive,0 10"

        # movewindow
        "$mainModSHIFT,right,moveactive,10 0"
        "$mainModSHIFT,left,moveactive,-10 0"
        "$mainModSHIFT,up,moveactive,0 -10"
        "$mainModSHIFT,down,moveactive,0 10"

        #volume
        ",XF86AudioRaiseVolume, exec, ~/.config/scripts/volume.sh volume_up" # increase volume
        ",XF86AudioLowerVolume, exec, ~/.config/scripts/volume.sh volume_down" # decreases volume

      ];


      bindm = [

        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"

      ];


    };
    extraConfig = ''
      # Make kitty keybindings more like vim
      # reduces opacity to know we are inside a submap
      bindr=CONTROL,Control_L,exec,hyprctl keyword decoration:active_opacity 0.6

      # keybinding for enabling kittyvimode
      bindr=CONTROL,Control_L,submap,kittyvimode

      # submap
      submap=kittyvimode

      # keybindings related to tabs in kitty
      bind=,T,exec, wtype -M ctrl -M shift t # open new tab
      bind=SHIFT,H,exec, wtype -M ctrl -M shift -P Left # previous tab
      bind=SHIFT,l,exec, wtype -M ctrl -M shift -P Right # nex tab

      # kebindings related to windos in kitty
      bind=,q,exec, wtype -M ctrl -M shift w # close window 
      bind=,RETURN,exec, kitty @ --to unix:/tmp/mykitty new-window # close window/tab
      bind=,H,exec, wtype -M ctrl -M shift [ # previous window
      bind=,L,exec, wtype -M ctrl -M shift ] # next window
      bind=,J,exec, wtype -M ctrl -M shift [ # previous window
      bind=,K,exec, wtype -M ctrl -M shift ] # next window

      # kitty scrollback_buffer
      bind=,P,exec, wtype -M ctrl -M shift h
      # show outputs of a command in scroll_back_buffer
      bind=,G,exec, wtype -M ctrl -M shift g

      # switch between window layouts in kitty
      bind=,S,exec, wtype -M ctrl -M shift l

      # reset opacity
      bind=,i,exec,hyprctl keyword decoration:active_opacity 1
      # use reset to go back to the global submap
      bind=,i,submap,reset

      # will reset the submap, meaning end the current one and return to the global one

      submap=reset
    '';

  };


}
