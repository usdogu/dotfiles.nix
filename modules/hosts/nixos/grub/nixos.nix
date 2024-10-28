{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.dogu.grub;
in
{
  imports = [ inputs.grub2-themes.nixosModules.default ];

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
    theme = lib.mkOption {
      description = "GRUB theme to use";
      default = "vimix";
      type = lib.types.str;
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
      grub2-theme = {
        inherit (cfg) enable theme;
      };
    };
  };
}
