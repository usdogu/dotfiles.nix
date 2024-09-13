{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  spotify, # unfree
  wget,
  wrapSpotify ? true, # set to false if you need only lib/libspotifyadblock.so
}:

let

  spotify-adblock = rustPlatform.buildRustPackage rec {
    pname = "spotify-adblock";
    version = "1.0.3";

    doCheck = false;

    src = fetchFromGitHub {
      owner = "abba23";
      repo = pname;
      rev = "5a3281dee9f889afdeea7263558e7a715dcf5aab";
      sha256 = "sha256-UzpHAHpQx2MlmBNKm2turjeVmgp5zXKWm3nZbEo0mYE=";
    };

    configUrl = "https://raw.githubusercontent.com/${src.owner}/${src.repo}/main/config.toml";

    cargoHash = "sha256-wPV+ZY34OMbBrjmhvwjljbwmcUiPdWNHFU3ac7aVbIQ=";

    postInstall = ''
      mkdir -p $out/etc/spotify-adblock
      cp config.toml $out/etc/spotify-adblock
    '';

    meta = with lib; {
      description = "Adblocker for Spotify";
      homepage = "https://github.com/abba23/spotify-adblock";
      license = licenses.unlicense;
      maintainers = [ ];
    };
  };

in
if (!wrapSpotify) then
  spotify-adblock
else

  stdenv.mkDerivation {
    inherit (spotify-adblock) pname version;
    buildInputs = [
      spotify-adblock
      spotify
      wget
    ];
    buildCommand = ''
      mkdir -p $out/bin
      cp ${spotify}/bin/spotify $out/bin/spotify-adblock
      chmod +w $out/bin/spotify-adblock
      # add code before "exec"
      sed -i -E 's#^exec#echo updating spotify blocklist in $HOME/.config/spotify-adblock/config.toml\necho to disable updates, run: touch $HOME/.config/spotify-adblock/dont-update\necho to view the update history, run: git -C $HOME/.config/spotify-adblock log\nmkdir -p $HOME/.config/spotify-adblock\n(\n  cd $HOME/.config/spotify-adblock\n  if [ ! -e dont-update ]; then\n    [ ! -d .git ] \&\& git -c init.defaultBranch=main init\n    ${wget}/bin/wget --timestamping ${spotify-adblock.configUrl}\n    git add config.toml\n    git commit -m "update config.toml" || true\n  fi\n)\nexport LD_PRELOAD=${spotify-adblock}/lib/libspotifyadblock.so\nexec#' $out/bin/spotify-adblock
    '';
  }
