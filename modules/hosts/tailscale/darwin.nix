{ config, lib, ... }:
let
  cfg = config.dogu.tailscale;
in
{
  config = lib.mkIf cfg.enable {
    dogu.homebrew.casks = [ "tailscale-app" ];
  };
}
