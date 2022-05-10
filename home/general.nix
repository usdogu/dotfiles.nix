{ config, lib, pkgs, ... }:

{
  home.file = {
    "org" = {
      source = ./configs/org;
      recursive = true;
    };
    ".mbsyncrc".source = ./configs/.mbsyncrc;
  };
  xdg.configFile."zathura/zathurarc".source = ./configs/zathurarc;
}
