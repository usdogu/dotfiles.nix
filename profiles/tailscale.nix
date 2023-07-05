{ pkgs, lib, config, inputs, ... }:

{
  services.tailscale.enable = true;

  age.secrets.tailscaleAuthKey.file =
    "${inputs.self}/secrets/tailscaleAuthKey.age";

  systemd.services.tailscaled-autoconnect = {
    description = "Automatic connection to Tailscale";
    after = [ "tailscaled.service" ];
    requires = [ "tailscaled.service" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      # wait for tailscaled to settle
      sleep 2

      # check if we are already authenticated to tailscale
      status="$(${
        lib.getExe config.services.tailscale.package
      } status -json | ${pkgs.jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      # otherwise authenticate with tailscale
      ${config.services.tailscale.package}/bin/tailscale up \
        --authkey file:${config.age.secrets.tailscaleAuthKey.path} \
        --ssh \
        --hostname=${config.networking.hostName}
    '';
  };
}
