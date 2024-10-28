{ config, lib, ... }:
let
  cfg = config.dogu.network;
in
{
  config = lib.mkIf cfg.enable {
    networking = {
      dns = [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
      ];
      knownNetworkServices = [
        "Wi-Fi"
        "Thunderbolt Bridge"
        "Tailscale Tunnel"
      ];
    };
  };
}
