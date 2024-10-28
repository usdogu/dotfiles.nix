{ inputs, pkgs, ... }:
let
  m = 60;
  h = 60 * m;
  d = 24 * h;
  y = 365 * d;
in
{
  imports = [ inputs.self.homeManagerModules.dogu ];
  home.stateVersion = "24.05";
  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs; [
    ripgrep
    fd
    wget
    lsd
    rm-improved
    tealdeer
    htop-vim
    jaq # alternative for jq
    home-manager
    fzf
    gh
    bun
  ];

  programs = {
    gpg.enable = true;
    bat = {
      enable = true;
      extraPackages = [ pkgs.bat-extras.batman ];
    };
    command-not-found.enable = false;
  };

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

  dogu = {
    git.enable = true;
    shell.enable = true;
    editors.enable = true;
  };
}
