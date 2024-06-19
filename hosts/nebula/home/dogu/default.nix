{ ... }:

{
  home.stateVersion = "24.05";
  imports = [
    ./packages.nix
    ./programs.nix
    ./xorg.nix
    ./gtk-qt.nix
    ./browser.nix
    ./sway.nix
    ./shell.nix
    ./services.nix
  ];
}
