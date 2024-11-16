{
  config,
  lib,
  ...
}:
let
  cfg = config.dogu.ssh;
in
{
  options.dogu.ssh = {
    enable = lib.mkEnableOption "ssh";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
  };
}
