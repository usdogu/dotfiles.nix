{ inputs, pkgs, ... }:

{
  environment.etc = {
    "nix/flake-channels/nixpkgs".source = inputs.nixpkgs;
    "nix/flake-channels/home-manager".source = inputs.home-manager;
  };

  nix = {
    package = pkgs.nixUnstable;
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      home-manager.flake = inputs.home-manager;
    };
    nixPath = [
      "nixpkgs=/etc/nix/flake-channels/nixpkgs"
      "home-manager=/etc/nix/flake-channels/home-manager"
    ];
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      builders-use-substitutes = true;
      auto-optimise-store = true;
      warn-dirty = false;
      trusted-users = [ "@wheel" ];
      substituters =
        [ "https://nix-community.cachix.org" "https://usdogu.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "usdogu.cachix.org-1:PKE38ObfSZFZiJUrioXXrcLoxqXX/EZcSDsCTBzd4hc="
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;
  documentation.nixos.enable = false;
}
