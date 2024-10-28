{ lib, config, ... }:
let
  cfg = config.dogu.nixSettings;
in
{
  config = lib.mkIf cfg.enable {
    services.nix-daemon.enable = true;
  };
}
