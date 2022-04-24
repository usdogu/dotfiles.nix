{ config, pkgs, inputs, ... }:

{
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [ epkgs.vterm ];
  };
  # services.emacs = {
  #   enable = true;
  #   extraPackages = pkgs.emacsPackages.vterm;
  # };
  home.sessionVariables.EDITOR = "nvim";
}
