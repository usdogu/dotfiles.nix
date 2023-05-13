{ pkgs, inputs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    recommendedEnvironment = true;
    extraConfig = ''
      $mod = SUPER

      monitor = HDMI-1, preferred, auto, 1

      env = _JAVA_AWT_WM_NONREPARENTING,1
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1

      # scale apps
      exec-once = xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2

      # set cursor for HL itself
      exec-once = hyprctl setcursor "Capitaine Cursors" 32

      master {
        new_is_master = false
      }

      misc {
        # disable auto polling for config file changes
        disable_autoreload = true
        focus_on_activate = true
        # disable dragging animation
        animate_mouse_windowdragging = false
      }

      # touchpad gestures
      gestures {
        workspace_swipe = true
        workspace_swipe_forever = true
      }

      input {
        kb_layout = tr

        # focus change on cursor move
        follow_mouse = 1
        accel_profile = flat
      }

      general {
        gaps_in = 0
        gaps_out = 0
        border_size = 0
      }

      decoration {
        blur = false
        drop_shadow = false
      }

      animations {
        enabled = false
      }

      dwindle {
        # keep floating dimentions while tiling
        pseudotile = true
        preserve_split = true
      }

      # telegram media viewer
      windowrulev2 = float, title:^(Media viewer)$

      # make Firefox PiP window floating and sticky
      windowrulev2 = float, title:^(Picture-in-Picture)$
      windowrulev2 = pin, title:^(Picture-in-Picture)$

      # throw sharing indicators away
      windowrulev2 = workspace special silent, title:^(Firefox — Sharing Indicator)$
      windowrulev2 = workspace special silent, title:^(.*is sharing (your screen|a window)\.)$

      # idle inhibit while watching videos
      windowrulev2 = idleinhibit focus, class:^(mpv|.+exe)$
      windowrulev2 = idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$
      windowrulev2 = idleinhibit fullscreen, class:^(firefox)$

      windowrulev2 = dimaround, class:^(gcr-prompter)$

      # fix xwayland apps
      windowrulev2 = rounding 0, xwayland:1, floating:1
      windowrulev2 = center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$
      windowrulev2 = size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$

      # mouse movements
      bindm = $mod, mouse:272, movewindow
      bindm = $mod, mouse:273, resizewindow
      bindm = $mod ALT, mouse:272, resizewindow

      # compositor commands
      bind = $mod SHIFT, E, exec, pkill Hyprland
      bind = $mod SHIFT, C, killactive,
      bind = $mod, F, fullscreen,
      bind = $mod, G, togglegroup,
      bind = $mod SHIFT, N, changegroupactive, f
      bind = $mod SHIFT, P, changegroupactive, b
      bind = $mod, R, togglesplit,
      bind = $mod, T, togglefloating,
      bind = $mod, P, pseudo,
      bind = $mod ALT, ,resizeactive,
      # toggle "monocle" (no_gaps_when_only)
      $kw = dwindle:no_gaps_when_only
      bind = $mod, M, exec, hyprctl keyword $kw $(($(hyprctl getoption $kw -j | jaq -r '.int') ^ 1))

      # utility
      # launcher
      bind = $mod SHIFT, Return, exec, pkill .anyrun-wrapped || anyrun
      # terminal
      bind = $mod, Return, exec, foot

      # move focus
      bind = $mod, l, movefocus, l
      bind = $mod, h, movefocus, r
      bind = $mod, k, movefocus, u
      bind = $mod, j, movefocus, d

      # window resize
      bind = $mod, S, submap, resize

      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset

      # media controls
      bindl = , XF86AudioPlay, exec, playerctl play-pause
      bindl = , XF86AudioPrev, exec, playerctl previous
      bindl = , XF86AudioNext, exec, playerctl next

      # volume
      bindle = , XF86AudioRaiseVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%+
      bindle = , XF86AudioLowerVolume, exec, wpctl set-volume -l "1.0" @DEFAULT_AUDIO_SINK@ 6%-
      bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

      # backlight
      bindle = , XF86MonBrightnessUp, exec, light -A 5
      bindle = , XF86MonBrightnessDown, exec, light -U 5

      # screenshot
      # stop animations while screenshotting; makes black border go away
      $screenshotarea = grimblast --notify copysave area
      bind = , Print, exec, $screenshotarea
      bind = $mod SHIFT, R, exec, $screenshotarea

      bind = CTRL, Print, exec, grimblast --notify --cursor copysave output
      bind = $mod SHIFT CTRL, R, exec, grimblast --notify --cursor copysave output

      bind = ALT, Print, exec, grimblast --notify --cursor copysave screen
      bind = $mod SHIFT ALT, R, exec, grimblast --notify --cursor copysave screen

      # workspaces
      # binds mod + [shift +] {1..10} to [move to] ws {1..10}
      ${builtins.concatStringsSep "\n" (builtins.genList (x:
        let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
        in ''
          bind = $mod, ${ws}, workspace, ${toString (x + 1)}
          bind = $mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
        '') 10)}

      # special workspace
      bind = $mod, minus, movetoworkspace, special
      bind = $mod SHIFT, minus, togglespecialworkspace, eDP-1

      # cycle workspaces
      bind = $mod, bracketleft, workspace, m-1
      bind = $mod, bracketright, workspace, m+1
      # cycle monitors
      bind = $mod SHIFT, braceleft, focusmonitor, l
      bind = $mod SHIFT, braceright, focusmonitor, r
    '';
  };

  home.packages = with pkgs; [
    foot
    rofi-wayland
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];
}
