{ config, lib, ... }:
let
  cfg = config.dogu.network;
in
{
  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager.enable = true;
      networkmanager.dns = "none";
      nameservers = [
        "127.0.0.1"
        "::1"
      ];
    };

    systemd.services = {
      NetworkManager-wait-online.enable = false;
      dnscrypt-proxy2.serviceConfig.StateDirectory = "dnscrypt-proxy";
    };
    services.dnscrypt-proxy2 = {
      enable = true;
      settings = {
        bootstrap_resolvers = [
          "1.1.1.1:53"
          "8.8.8.8:53"
        ];
        server_names = [ "cloudflare" ];
        sources.public-resolvers = {
          urls = [
            "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
            "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
          ];
          minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
          cache_file = "public-resolvers.md";

        };
      };
    };
  };
}
