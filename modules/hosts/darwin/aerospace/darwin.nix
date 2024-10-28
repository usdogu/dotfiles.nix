{ config, lib, ... }:
let
  cfg = config.dogu.aerospace;
in
{
  options.dogu.aerospace = {
    enable = lib.mkEnableOption "aerospace";
  };

  config = lib.mkIf cfg.enable {

    services.aerospace = {
      enable = true;
      settings = {
        accordion-padding = 0;
        mode = {
          main.binding = {
            "alt-1" = "workspace 1";
            "alt-2" = "workspace 2";
            "alt-3" = "workspace 3";
            "alt-4" = "workspace 4";
            "alt-5" = "workspace 5";
            "alt-6" = "workspace 6";
            "alt-7" = "workspace 7";
            "alt-8" = "workspace 8";
            "alt-9" = "workspace 9";
            "alt-shift-1" = "move-node-to-workspace 1";
            "alt-shift-2" = "move-node-to-workspace 2";
            "alt-shift-3" = "move-node-to-workspace 3";
            "alt-shift-4" = "move-node-to-workspace 4";
            "alt-shift-5" = "move-node-to-workspace 5";
            "alt-shift-6" = "move-node-to-workspace 6";
            "alt-shift-7" = "move-node-to-workspace 7";
            "alt-shift-8" = "move-node-to-workspace 8";
            "alt-shift-9" = "move-node-to-workspace 9";
            "alt-h" = "focus left";
            "alt-j" = "focus down";
            "alt-k" = "focus up";
            "alt-l" = "focus right";
            "alt-shift-h" = "move left";
            "alt-shift-j" = "move down";
            "alt-shift-k" = "move up";
            "alt-shift-l" = "move right";
            "alt-shift-tab" = "move-workspace-to-monitor --wrap-around next";
            "alt-slash" = "layout tiles horizontal vertical";
            "alt-comma" = "layout accordion horizontal vertical";
            "alt-shift-semicolon" = "mode service";
            "alt-r" = "mode resize";
          };
          resize.binding = {
            "enter" = "mode main";
            "esc" = "mode main";
            "h" = "resize width +50";
            "j" = "resize height +50";
            "k" = "resize height -50";
            "l" = "resize width -50";
          };
          service.binding = {
            "alt-shift-h" = [
              "join-with left"
              "mode main"
            ];
            "alt-shift-j" = [
              "join-with down"
              "mode main"
            ];
            "alt-shift-k" = [
              "join-with up"
              "mode main"
            ];
            "alt-shift-l" = [
              "join-with right"
              "mode main"
            ];
            "backspace" = [
              "close-all-windows-but-current"
              "mode main"
            ];
            "esc" = [
              "reload-config"
              "mode main"
            ];
            "f" = [
              "layout floating tiling"
              "mode main"
            ];
            "r" = [
              "flatten-workspace-tree"
              "mode main"
            ];
          };
        };
      };
    };
  };
}
