inputs:

let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in

{
  nimblocks = pkgs.callPackage "${inputs.self}/packages/nimblocks" {};
  spotify-adblock = pkgs.callPackage "${inputs.self}/packages/spotify-adblock" {};
}
