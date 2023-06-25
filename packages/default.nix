{ ... }:

{
  perSystem = { pkgs, lib, ... }: {
    packages = lib.genAttrs
      (lib.remove "default.nix" (lib.attrNames (builtins.readDir ./.)))
      (p: pkgs.callPackage ./${p} { });
  };
}
