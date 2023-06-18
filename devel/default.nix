{ inputs, ... }:

{
  perSystem = { pkgs, inputs', lib, ... }: {
    apps = lib.mapAttrs' (host: cfg: {
      name = "deploy-${host}";
      value.program = toString (pkgs.writeShellScript "deploy-${host}" ''
        if [[ -n "$1" ]]; then 
          TASK="$1" 
        else 
          TASK="switch" 
        fi
        set -x
        NIX_SSHOPTS="-tt" NIXPKGS_ALLOW_UNFREE=1 ${
          lib.getExe (pkgs.nixos-rebuild.override { nix = pkgs.nixUnstable; })
        } "$TASK" -s --use-remote-sudo --fast --impure --flake ${inputs.self}#${host} \
        --target-host ${cfg.config.networking.hostName} ${
          lib.optionalString (host == "nebula")
          "--build-host ${cfg.config.networking.hostName}"
        }
      '');
    }) inputs.self.nixosConfigurations;
  };
}
