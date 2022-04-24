{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Doğu Us";
    userEmail = "uspro@disroot.org";
    delta.enable = true;
    signing = {
      key = "425F13EE644429FD";
      signByDefault = true;
    };
    extraConfig = { credential.helper = "store"; };
  };
}
