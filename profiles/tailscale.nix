{ config, ... }:

{
  age.secrets.tailscaleAuthKey.file = ../secrets/tailscaleAuthKey.age;

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
}
