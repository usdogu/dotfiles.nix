{ ... }:

{
  home.stateVersion = "23.05";
  imports = [
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./editors.nix
    ./music.nix
    ./git.nix
    ./xorg.nix
    ./shell.nix
    ./gtk-qt.nix
    ./devel.nix
    ./browser.nix
    ./wm.nix
    ./anyrun.nix
  ];
}
