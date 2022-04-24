{ config, pkgs, inputs, ... }:

{
  imports = [
    ./xorg.nix
    ./nix-nixpkgs.nix
  ];
}
