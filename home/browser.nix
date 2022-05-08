{ config, pkgs, inputs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; # ublock origin
      }
      {
        id = "ihlenndgcmojhcghmfjfneahoeklbjjh"; # cVim
      }
      {
        id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; # Dark Reader
      }
      {
        id = "nngceckbapebfimnlniiiahkandclblb"; # Bitwarden
      }
      {
        id = "icallnadddjmdinamnolclfjanhfoafe"; # Fast Forward
      }
      {
        updateUrl =
          "https://raw.githubusercontent.com/libredirect/libredirect/master/src/updates/updates.xml";
        id = "ongajcjccibkomjojhfmjedolopocllf"; # LibRedirect
      }
      {
        id = "fihnjjcciajhdojfnbdddfaoknhalnja"; # I don't care about cookies
      }
    ];
  };
}
