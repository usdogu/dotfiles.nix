{ lib, ... }:
{
  options.dogu.agenix = {
    enable = lib.mkEnableOption "agenix";
  };
}
