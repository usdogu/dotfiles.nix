{ pkgs, ... }:
let
  m = 60;
  h = 60 * m;
  d = 24 * h;
  y = 365 * d;
in
{
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    sshKeys = [ "310A8B8E991418079ABC4E97900A617A81B0121F" ];
    pinentryPackage = if pkgs.stdenv.isLinux then pkgs.pinentry-gnome3 else pkgs.pinentry_mac;
    defaultCacheTtl = 12 * h;
    defaultCacheTtlSsh = 12 * h;
    maxCacheTtl = 100 * y;
    maxCacheTtlSsh = 100 * y;
  };
}
