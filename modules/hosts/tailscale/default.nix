{ lib, ... }:
{
  options.dogu.tailscale = {
    enable = lib.mkEnableOption "tailscale";
  };
}
