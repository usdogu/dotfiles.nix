{
  lib,
  config,
  ...
}:
let
  cfg = config.dogu.alacritty;
in
{
  options.dogu.alacritty = {
    enable = lib.mkEnableOption "alacritty";
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        # gruvbox_dark
        colors = {
          primary = {
            background = "0x282828";
            foreground = "0xebdbb2";
          };
          normal = {
            black = "0x282828";
            red = "0xcc241d";
            green = "0x98971a";
            yellow = "0xd79921";
            blue = "0x458588";
            magenta = "0xb16286";
            cyan = "0x689d6a";
            white = "0xa89984";
          };
          bright = {
            black = "0x928374";
            red = "0xfb4934";
            green = "0xb8bb26";
            yellow = "0xfabd2f";
            blue = "0x83a598";
            magenta = "0xd3869b";
            cyan = "0x8ec07c";
            white = "0xebdbb2";
          };
        };

        font = {
          normal = {
            family = "Iosevka Nerd Font";
            style = "Regular";
          };
          bold = {
            family = "Iosevka Nerd Font";
            style = "Bold";
          };
          italic = {
            family = "Iosevka Nerd Font";
            style = "Italic";
          };
          bold_italic = {
            family = "Iosevka Nerd Font";
            style = "Bold Italic";
          };
          size = 13;
        };
      };
    };
  };
}
