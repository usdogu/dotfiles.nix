{ config, lib, ... }:
let
  cfg = config.dogu.homebrew;
in
{
  options.dogu.homebrew = {
    enable = lib.mkEnableOption "homebrew";
    casks = lib.mkOption {
      description = "casks to install";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
    masApps = lib.mkOption {
      description = "MAS apps to install";
      type = lib.types.attrsOf lib.types.int;
      default = { };
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      inherit (cfg) enable casks masApps;
      caskArgs.no_quarantine = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "zap";
        upgrade = true;
      };
    };
  };
}
