{ config, ... }:

{
  age.secrets.tailscaleAuthKey.file = ../secrets/tailscaleAuthKey.age;

  services.tailscale = {
    enable = true;
    authKeyFile = config.age.secrets.tailscaleAuthKey.path;
    useRoutingFeatures = "both";
    extraSetFlags = [ "--advertise-exit-node" ];
    extraUpFlags = [
      "--ssh"
    ];
  };
}
