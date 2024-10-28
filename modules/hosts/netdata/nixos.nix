{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.dogu.netdata;
in
{
  options.dogu.netdata = {
    enable = lib.mkEnableOption "netdata";
  };

  config = lib.mkIf cfg.enable {
    age.secrets.netdataClaimToken.file = inputs.self + /secrets/netdataClaimToken.age;

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
  };
}
