{ pkgs, ... }:

{
  programs = {
    gpg.enable = true;
    bat = {
      enable = true;
      extraPackages = [ pkgs.bat-extras.batman ];
    };
  };
}
