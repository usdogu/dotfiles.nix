{ config, pkgs, inputs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
  services.emacs.enable = true;
  home.file.".doom.d" = {
    source = ./configs/.doom.d;
    recursive = true;
  };
  home.sessionVariables.EDITOR = "nvim";
}
