{ pkgs, ... }:

{
  gtk = {
    enable = true;
    font = {
      name = "Iosevka Medium Italic 12";
      package = (pkgs.nerdfonts.override { fonts = [ "Iosevka" ]; });
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
    platformTheme = "gtk";
    style.name = "gtk2";
  };

  home.pointerCursor = {
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors-white";
    gtk.enable = true;
    x11.enable = true;
  };

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [ emojione ];
}
