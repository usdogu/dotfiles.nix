{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.dogu.sway;
in
{
  options.dogu.sway = {
    enable = lib.mkEnableOption "sway";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      config = {
        bars = [ ];
        terminal = "alacritty";
        menu = "bemenu-run";
        modifier = "Mod4";
        input = {
          "type:keyboard" = {
            xkb_layout = "us,tr";
            xkb_numlock = "enabled";
          };
        };
        fonts = {
          names = [ "Iosevka Nerd Font" ];
        };
        window = {
          border = 0;
          titlebar = false;
          hideEdgeBorders = "both";
          commands = [
            {
              criteria = {
                shell = ".*";
              };
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

        startup = [
          {
            command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            always = true;
          }
        ];

        keybindings =
          let
            inherit (config.wayland.windowManager.sway.config) modifier;
            inherit (config.wayland.windowManager.sway.config) menu;
          in
          lib.mkOptionDefault {
            "${modifier}+Shift+c" = "kill";
            "${modifier}+Shift+r" = "reload";
            "${modifier}+Shift+Return" = "exec ${menu}";
            "Print" = "exec ${pkgs.grim}/bin/grim -t png - | ${pkgs.wl-clipboard}/bin/wl-copy -t 'image/png'";
            "${modifier}+Print" =
              "exec ${pkgs.grim}/bin/grim -t png -g \"$(${pkgs.slurp}/bin/slurp)\" - | ${pkgs.wl-clipboard}/bin/wl-copy -t 'image/png'";
            "${modifier}+c" = "exec ${pkgs.clipman}/bin/clipman pick -t bemenu";
            "${modifier}+Shift+t" = "input type:keyboard xkb_switch_layout next";
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
        exec ${pkgs.wl-clipboard}/bin/wl-paste -t text --watch ${pkgs.clipman}/bin/clipman store --no-persist
      '';
    };

    programs.swaylock.enable = true;
    home.packages = with pkgs; [ bemenu ];
  };
}
