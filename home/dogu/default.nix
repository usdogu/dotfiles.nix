{ ... }:

{
  home.stateVersion = "24.05";
  systemd.user.startServices = "sd-switch";

  imports = [
    ./packages.nix
    ./programs.nix
    ./editors.nix
    ./git.nix
    ./shell.nix
    ./services.nix
  ];
}
