{
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.dogu.tailscale;
in
{
  config = lib.mkIf cfg.enable {
    age.secrets.tailscaleAuthKey.file = inputs.self + /secrets/tailscaleAuthKey.age;

    services.tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.tailscaleAuthKey.path;
      useRoutingFeatures = "both";
      extraSetFlags = [
        "--ssh"
        "--advertise-exit-node"
        "--exit-node-allow-lan-access"
      ];
    };
  };
}
