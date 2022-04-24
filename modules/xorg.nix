{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "tr";
  };
}
