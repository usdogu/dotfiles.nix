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
    age.secrets.tailscale-key.file = inputs.self + /secrets/tailscale-key.age;

    services.tailscale = {
      enable = true;
      authKeyFile = config.age.secrets.tailscale-key.path;
      useRoutingFeatures = "both";
      extraSetFlags = [
        "--ssh"
        "--advertise-exit-node"
        "--exit-node-allow-lan-access"
      ];
    };
  };
}
