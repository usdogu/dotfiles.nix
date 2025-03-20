{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.dogu.theming;
in
{
  options.dogu.theming = {
    enable = lib.mkEnableOption "theming";
  };

  config = lib.mkIf cfg.enable {
    xresources.properties = {
      "*background" = "#282828";
      "*foreground" = "#ebdbb2";
      "*color0" = "#282828";
      "*color8" = "#928374";
      "*color1" = "#cc241d";
      "*color9" = "#fb4934";
      "*color2" = "#98971a";
      "*color10" = "#b8bb26";
      "*color3" = "#d79921";
      "*color11" = "#fabd2f";
      "*color4" = "#458588";
      "*color12" = "#83a598";
      "*color5" = "#b16286";
      "*color13" = "#d3869b";
      "*color6" = "#689d6a";
      "*color14" = "#8ec07c";
      "*color7" = "#a89984";
      "*color15" = "#ebdbb2";
    };
    gtk = {
      enable = true;
      font = {
        name = "Iosevka Medium Italic 12";
        package = pkgs.nerd-fonts.iosevka;
      };
      iconTheme = {
        name = "oomox-gruvbox-dark";
        package = pkgs.gruvbox-dark-icons-gtk;
      };
      theme = {
        name = "gruvbox-dark";
        package = pkgs.gruvbox-dark-gtk;
      };
    };
    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = "adwaita-dark";
    };

    home.pointerCursor = {
      enable = true;
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors-white";
      gtk.enable = true;
      x11.enable = true;
      sway.enable = true;
    };

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [ emojione ];
  };
}
