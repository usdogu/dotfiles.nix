{ pkgs, ... }:

{
  gtk = {
    enable = true;
    cursorTheme = {
      name = "capitaine-cursors-white";
      package = pkgs.capitaine-cursors;
    };
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
}
