{
  config,
  lib,
  ...
}:
let
  cfg = config.dogu.grub;
in
{

  options.dogu.grub = {
    enable = lib.mkEnableOption "GRUB settings";
    device = lib.mkOption {
      description = "The device on which the GRUB boot loader will be installed";
      type = lib.types.str;
    };
    useOSProber = lib.mkEnableOption "os-prober";
    default = lib.mkOption {
      default = "0";
      type = lib.types.either lib.types.int lib.types.str;
      apply = lib.toString;
      description = ''
        Index of the default menu item to be booted.
        Can also be set to "saved", which will make GRUB select
        the menu item that was used at the last boot.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      grub = {
        inherit (cfg)
          enable
          device
          useOSProber
          default
          ;
      };
    };
  };
}
