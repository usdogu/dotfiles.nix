{ pkgs, config, ... }:
{
  age.secrets.netdataClaimToken.file = ../secrets/netdataClaimToken.age;

  services.netdata = {
    enable = true;
    package = pkgs.netdataCloud;
    claimTokenFile = config.age.secrets.netdataClaimToken.path;
  };
}
