{ pkgs, ... }:
pkgs.buildNpmPackage {
  pname = "vtsls";
  version = "0.2.5";

  src = ./.;
  npmDepsHash = "sha256-Cvi2AHEXaWZ4zoUAnBXVsDPVbUtKB7aCGYNDExE7iFc=";
  dontNpmBuild = true;

  buildInputs = with pkgs; [
    makeWrapper
    nodejs_latest
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    mkdir -p $out/bin
    cp -r node_modules/ $out/lib

    makeWrapper ${pkgs.nodejs}/bin/node $out/bin/vtsls \
      --add-flags "$out/lib/node_modules/@vtsls/language-server/bin/vtsls.js" \
      --chdir "$out/lib/node_modules/@vtsls/language-server"

    runHook postInstall
  '';
}
