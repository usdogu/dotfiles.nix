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
    taps = lib.mkOption {
      description = "Homebrew repositories to tap";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      inherit (cfg)
        enable
        casks
        masApps
        taps
        ;
      caskArgs.no_quarantine = true;
      onActivation = {
        autoUpdate = true;
        cleanup = "zap";
        upgrade = true;
      };
    };
  };
}
