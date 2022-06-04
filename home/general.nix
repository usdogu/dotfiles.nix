{ config, lib, pkgs, ... }:

{
  home.file = {
    ".mbsyncrc".source = ./configs/.mbsyncrc;
    "org/elfeed.org".source = ./configs/org/elfeed.org;
  };
  xdg.configFile."zathura/zathurarc".source = ./configs/zathurarc;
}
