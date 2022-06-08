{ config, lib, pkgs, ... }:

{
  home.file = {
    "org/elfeed.org".source = ./configs/org/elfeed.org;
  };
  xdg.configFile."zathura/zathurarc".source = ./configs/zathurarc;
}
