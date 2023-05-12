{ ... }:

{
  services = {
    gnome-keyring.enable = true;
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      sshKeys = [ "310A8B8E991418079ABC4E97900A617A81B0121F" ];
    };
  };
}

