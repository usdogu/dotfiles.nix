{ self, ... }@inputs:

let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in

{ }
