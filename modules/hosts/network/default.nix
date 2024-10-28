{ lib, ... }:
{
  options.dogu.network = {
    enable = lib.mkEnableOption "networking";
  };
}
