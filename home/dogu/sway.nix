{ pkgs, lib, config, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    config = {
      bars = [ ];
      terminal = "foot";
      menu = "${pkgs.bemenu}/bin/bemenu-run";
      modifier = "Mod4";
      input = { "*" = { xkb_layout = "tr"; }; };
      fonts = { names = [ "Iosevka Nerd Font" ]; };
      window = {
        border = 0;
        titlebar = false;
        hideEdgeBorders = "both";
        commands = [
          {
            criteria = { shell = ".*"; };
            command = "inhibit_idle fullscreen";
          }
          {
            criteria = {
              app_id = "telegramdesktop";
              title = "TelegramDesktop";
            };
            command = "floating enable; stick enable";
          } # Main window is called "Telegram (N)", popups are called "TelegramDesktop"
          {
            criteria = {
              app_id = "firefox";
              title = "Picture-in-Picture";
            };
            command = "floating enable; sticky enable";
          }
          {
            criteria = {
              app_id = "firefox";
              title = "Firefox — Sharing Indicator";
            };
            command = "floating enable; sticky enable";
          }
          {
            criteria = {
              app_id = "";
              title = ".+\\(\\/run\\/current-system\\/sw\\/bin\\/gpg .+";
            };
            command = "floating enable; sticky enable";
          }
        ];
      };

      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
        menu = config.wayland.windowManager.sway.config.menu;
      in lib.mkOptionDefault {
        "${modifier}+Shift+c" = "kill";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Shift+Return" = "exec ${menu}";
        "Print" =
          "exec ${pkgs.grim}/bin/grim -t png - | ${pkgs.wl-clipboard}/bin/wl-copy -t 'image/png'";
        "${modifier}+Print" =
          "exec ${pkgs.grim}/bin/grim -t png -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy -t 'image/png'";
      };
    };
    extraSessionCommands = ''
      export XDG_SESSION_DESKTOP=sway
      export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
      export CLUTTER_BACKEND=wayland
      export ECORE_EVAS_ENGINE=wayland-egl
      export ELM_ENGINE=wayland_egl
      export NO_AT_BRIDGE=1
    '';
    wrapperFeatures.gtk = true;
    extraConfig = ''
      seat seat0 xcursor_theme "capitaine-cursors-white" 32
    '';
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Iosevka Nerd Font :pixelsize=15:antialias=true:autohint=true";
      };
      colors = {
        background = "282828";
        foreground = "ebdbb2";
        regular0 = "282828";
        regular1 = "cc241d";
        regular2 = "98971";
        regular3 = "d79921";
        regular4 = "458588";
        regular5 = "b16286";
        regular6 = "689d6a";
        regular7 = "a89984";
        bright0 = "928374";
        bright1 = "fb4934";
        bright2 = "b8bb26";
        bright3 = "fabd2f";
        bright4 = "83a598";
        bright5 = "d3869b";
        bright6 = "8ec07c";
        bright7 = "ebdbb2";
      };
    };
  };
}
