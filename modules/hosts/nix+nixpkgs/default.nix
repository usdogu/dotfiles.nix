{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.dogu.nixSettings;
in
{
  imports = [ inputs.nix-monitored.nixosModules.default ]; # nixos and darwin modules are the same

  options.dogu.nixSettings = {
    enable = lib.mkEnableOption "nix settings";
  };

  config = lib.mkIf cfg.enable {
    environment.variables.NIXPKGS_ALLOW_UNFREE = "1";

    nix = {
      monitored.enable = true;
      registry = lib.mapAttrs (_: value: { flake = value; }) inputs;
      nixPath = lib.mapAttrsToList (k: v: "${k}=${v.to.path}") config.nix.registry;
      channel.enable = true;
      settings = {
        experimental-features = [
          "nix-command"
          "flakes"
          "cgroups"
          "auto-allocate-uids"
        ];
        builders-use-substitutes = true;
        warn-dirty = false;
        trusted-users = [
          "@wheel"
          "dogu"
        ];
        substituters = [
          "https://nix-community.cachix.org"
          "https://usdogu.cachix.org"
        ];
        trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "usdogu.cachix.org-1:PKE38ObfSZFZiJUrioXXrcLoxqXX/EZcSDsCTBzd4hc="
        ];
      };
    };
    nixpkgs.config.allowUnfree = true;
  };
}
