{ config, lib, ... }:
let
  cfg = config.dogu.tailscale;
in
{
  config = lib.mkIf cfg.enable {
    homebrew.casks = [ "tailscale" ];
  };
}
