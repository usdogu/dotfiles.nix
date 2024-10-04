{ pkgs, config, ... }:
{
  age.secrets.netdataClaimToken.file = ../secrets/netdataClaimToken.age;

  services.netdata = {
    enable = true;
    package = pkgs.netdataCloud;
    claimTokenFile = config.age.secrets.netdataClaimToken.path;
    config = {
      global = {
        history = "604800"; # 1 week
        "update every" = "5";
      };
      logs.level = "error";
      web.mode = "none";
    };
  };
}
