{ lib, nimPackages, nim, libX11 }:
let
  nimx11 = nimPackages.buildNimPackage rec {
    name = "x11";
    src = fetchTarball {
      url = "https://github.com/nim-lang/x11/archive/master.tar.gz";
      sha256 = "0h770z36g2pk49pm5l1hmk9bi7a58w8csd7wqxcwy0bi41g74x6r";
    };
  };
in
nimPackages.buildNimPackage rec {
  name = "nimblocks";
  nimBinOnly = true;
  src = fetchTarball {
    url = "https://github.com/usdogu/nimblocks/archive/main.tar.gz";
    sha256 = "0vl7yajv1ix5bxvzji3cfr4xy9432jfim36sr6m41dpyvrf8dpkr";
  };
  buildInputs = [ nimx11 libX11 ];

  meta = with lib; {
    description = "A dwm status bar written in Nim";
    homepage = "https://github.com/usdogu/nimblocks/";
    license = licenses.unlicense;
    platforms = platforms.unix;
  };
}
